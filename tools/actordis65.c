/*
 * actordis65 - SMB actor object decoder
 *
 * Copyright 2024 Matthew Gilmore
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 * contributors may be used to endorse or promote products derived
 * from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 * CONTRIBUTORS AS IS AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

#include <stdio.h>

#define	END_CHAR	0xFF

static void print_E(int pos_x);
static void print_F(int pos_x);
static void print_norm(int pos_x, int pos_y);

int main(int argc, char *argv[])
{
	int pos_x, pos_y;
	int c;

	while ((c = getchar()) != EOF) {
		if (c == END_CHAR) {
			printf("\t.byte\tCOURSE_ACTORS_END\n\n");
			continue;
		}

		pos_x = (c >> 4);
		pos_y = (c & 0xF);	

		switch (pos_y) {
		case 0xE:
			print_E(pos_x);
			break;
		case 0xF:
			print_F(pos_x);
			break;
		default:
			print_norm(pos_x, pos_y);
			break;
		}
	}

	return 0;
}

static void print_E(int pos_x)
{
	int c;
	int new_page;
	int course_type;
	int course_idx;
	int course_no;
	int startpage;
	const char *course_sub = NULL;

	c = getchar();
	new_page = (c & 0x80);
	course_type = (c & 0x60) >> 5;
	course_idx = (c & 0x1F);
	switch (course_type) {
	case 0:
		course_sub = "WATER";
		break;
	case 1:
		course_sub = "OVERWORLD";
		break;
	case 2:
		course_sub = "UNDERGROUND";
		break;
	case 3:
		course_sub = "CASTLE";
		break;
	default:
		course_sub = "WATER";
		break;
	}

	if (new_page)
		printf("\n");

	printf("\t.word\t(COURSE_ACTORS_TYPE_E|COURSE_ACTORS_POS_X_%X", pos_x);

	if (new_page)
		printf("|COURSE_ACTORS_NEW_PAGE");

	printf("|COURSE_ACTORS_SUBSPACE_%s", course_sub);
	printf("|COURSE_ACTORS_SUBSPACE_%s_%.2d", course_sub, course_idx+1);

	printf(")\n");

	c = getchar();
	course_no = (c >> 5);
	startpage = (c & 0x1F);

	printf("\t.byte\t(COURSE_ACTORS_TYPE_E_COURSE_NO_%.1X|COURSE_ACTORS_TYPE_E_STARTPAGE_%.2X)\n", course_no+1, startpage);
	putchar('\n');
}

static void print_F(int pos_x)
{
	int c;
	int new_page;
	int hard_only;
	int page_loc;

	c = getchar();
	new_page = (c & 0x80);
	hard_only = (c & 0x40);
	page_loc = (c & 0x3F);

	printf("\n");

	printf("\t.word\t(COURSE_ACTORS_TYPE_F|COURSE_ACTORS_POS_X_%X", pos_x);

	if (new_page)
		printf("|COURSE_ACTORS_NEW_PAGE");
	if (hard_only)
		printf("|COURSE_ACTORS_HARD_ONLY");

	printf("|COURSE_ACTORS_PAGE_LOC_%.2X", page_loc);

	printf(")\n");
}

static char *names[] = {
	"KOOPA_GREEN",
	"01",
	"BUZZY_BEETLE",
	"KOOPA_RED",
	"04",
	"HAMMER_BRO",
	"GOOMBA",
	"BLOOBER",
	"BULLET_SWARM",
	"09",
	"CHEEP_GREY",
	"CHEEP_RED",
	"PODOBOO",
	"PIRANHA_PLANT",
	"PARA_GREEN_J",
	"PARA_RED_F",
	"PARA_GREEN_F",
	"LAKITU",
	"SPINY",
	"13",
	"CHEEP_FLY",
	"BOWSER_FLAME",
	"FIREWORKS",
	"BULLET_CHEEP_SWARM",
	"SWARM_STOP",
	"19",
	"1A",
	"FIREBAR_CLOCK_SLOW",
	"FIREBAR_CLOCK_FAST",
	"FIREBAR_COUNTER_SLOW",
	"FIREBAR_COUNTER_FAST",
	"FIREBAR_LONG",
	"20",
	"21",
	"22",
	"23",
	"PLAT_BAL",
	"PLAT_STD_V",
	"PLAT_L_UP",
	"PLAT_L_DOWN",
	"PLAT_STD_H",
	"PLAT_DROP",
	"PLAT_STD_H_B",
	"PLAT_S_UP",
	"PLAT_S_DOWN",
	"BOWSER",
	"POWER_UP",
	"VINE",
	"FLAG_ENEMY",
	"FLAG_VICTORY",
	"SPRING",
	"BULLET",
	"WARP",
	"TOAD",
	"36",
	"GOOMBA_TRIO_LO",
	"GOOMBA_DUO_LO",
	"GOOMBA_TRIO_HI",
	"GOOMBA_DUO_HI",
	"KOOPA_TRIO_LO",
	"KOOPA_DUO_LO",
	"KOOPA_TRIO_HI",
	"KOOPA_DUO_HI",
	"3F"
};

static void print_norm(int pos_x, int pos_y)
{
	int c;
	int new_page;
	int hard_mode;
	int actor_id;
	int named_actor = 1;
	const char *actor_name = NULL;

	c = getchar();
	new_page = (c & 0x80);
	hard_mode = (c & 0x40);
	actor_id = (c & 0x3F);

	if (new_page)
		printf("\n");

	printf("\t.word\t(COURSE_ACTORS_POS_Y_%.1X|COURSE_ACTORS_POS_X_%.1X", pos_y, pos_x);

	if (new_page)
		printf("|COURSE_ACTORS_NEW_PAGE");
	if (hard_mode)
		printf("|COURSE_ACTORS_HARD_ONLY");

	printf("|COURSE_ACTORS_ID_%s)\n", names[actor_id]);
}
