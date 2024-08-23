#include <stdio.h>

#define	END_CHAR	0xFD

static void print_header(void);
static void print_C(int pos_x);
static void print_D(int pos_x);
static void print_E(int pos_x);
static void print_F(int pos_x);
static void print_norm(int pos_x, int pos_y);

int main(int argc, char *argv[])
{
	int pos_x, pos_y;
	int c;

	print_header();

	while ((c = getchar()) != EOF) {
		if (c == END_CHAR) {
			printf("\t.byte\tCOURSE_SCENERY_END\n\n");
			continue;
		}

		pos_x = (c >> 4);
		pos_y = (c & 0xF);	

		switch (pos_y) {
		case 0xC:
			print_C(pos_x);
			break;
		case 0xD:
			print_D(pos_x);
			break;
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

static const char *ledges[] = {
	"TREE",
	"MUSHROOM",
	"CANNON",
	"CLOUD"
};

static const char *bg[] = {
	"NONE",
	"CLOUD",
	"MNT_BUSH",
	"TREE_FENCE"
};

static const char *enter_pos_vals[] = {
	"00_A",
	"20",
	"B0_A",
	"50",
	"00_B",
	"00_C",
	"B0_B",
	"B0_C"
};

static const char *non_mask_vals[] = {
	"FG_NONE",
	"FG_WATER",
	"FG_WALLS",
	"FG_SURFACE",
	"BG_COL_NONE",
	"BG_COL_WATER",
	"BG_COL_OVERWORLD",
	"BG_COL_UNDERGROUND"
};

static void print_header(void)
{
	int c;
	unsigned int ledge_type, bg_id, fg_mask, timer_setting, enter_pos, fg_bg_col_id;

	c = getchar();
	timer_setting = (c & 0xC0) >> 6;
	enter_pos = (c & 0x38) >> 3;
	fg_bg_col_id = (c & 0x7);

	c = getchar();
	ledge_type = (c & 0xC0) >> 6;
	bg_id = (c & 0x30) >> 4;
	fg_mask = (c & 0xF);

	printf("\t.word\t(COURSE_AREA_LEDGE_%s", ledges[ledge_type]);
	printf("|COURSE_BG_%s", bg[bg_id]);
	printf("|COURSE_FG_MASK_%d", fg_mask);
	printf("|COURSE_TIMER_SETTING_%d", timer_setting);
	printf("|COURSE_SCENERY_ENTER_POS_%s", enter_pos_vals[enter_pos]);
	printf("|COURSE_SCENERY_%s", non_mask_vals[fg_bg_col_id]);

	printf(")\n\n");
}

static const char *obj_a[] = {
	"PIT",
	"PULLEY",
	"BRIDGE_HI",
	"BRIDGE_MID",
	"BRIDGE_LO",
	"WATERHOLE",
	"BLOCK_QHI",
	"BLOCK_QLO"
};

static void print_C(int pos_x)
{
	int c;
	int new_page;
	unsigned int id, dimension;

	c = getchar();
	new_page = (c & 0x80);
	id = (c & 0x70) >> 4;
	dimension = (c & 0xF) + 1;

	if (new_page)
		printf("\n");

	printf("\t.word\t(COURSE_SCENERY_TYPE_C|COURSE_SCENERY_POS_X_%X", pos_x);

	if (new_page)
		printf("|COURSE_SCENERY_NEW_PAGE");
	
	printf("|COURSE_OBJ_A_%s", obj_a[id]);
	printf("|COURSE_OBJ_DIM_%d", dimension);
	
	printf(")\n");
}

static const char *obj_d[] = {
	"PIPE_INTRO",
	"POLE",
	"BRIDGE_AXE",
	"BRIDGE_DRAW",
	"BRIDGE",
	"LOCK_WARP",
	"LOCK_END",
	"LOCK_START",
	"SWARM_A",
	"SWARM_B",
	"SWARM_C",
	"LOOP",
#ifdef	SMB2
	"C5BE",
	"C5C2"
#endif
};

static void print_D(int pos_x)
{
	int c;
	int new_page;
	int is_object;
	unsigned int id;

	c = getchar();
	new_page = (c & 0x80);
	is_object = (c & 0x40);
	id = (c & 0x3F);

	if (!is_object)
		id &= 0x1F;

	if (new_page)
		printf("\n");

	printf("\t.word\t(COURSE_SCENERY_TYPE_D|COURSE_SCENERY_POS_X_%X", pos_x);

	if (new_page)
		printf("|COURSE_SCENERY_NEW_PAGE");
	if (is_object)
		printf("|COURSE_SCENERY_TYPE_D_MASK");

	if (is_object)
		printf("|COURSE_OBJ_D_%s", obj_d[id]);
	else
		printf("|COURSE_PAGE_D_%X", id);

	printf(")\n");
}

static void print_E(int pos_x)
{
	int c;
	int new_page;
	int non_mask;
	unsigned int id, mask_id;

	c = getchar();
	new_page = (c & 0x80);
	non_mask = (c & 0x40);
	id = non_mask ? (c & 0x07) : ((c & 0x30) >> 4);
	mask_id = (c & 0xF);

	if (new_page)
		printf("\n");

	printf("\t.word\t(COURSE_SCENERY_TYPE_E|COURSE_SCENERY_POS_X_%X", pos_x);

	if (new_page)
		printf("|COURSE_SCENERY_NEW_PAGE");
	if (non_mask)
		printf("|COURSE_OBJ_E_FG_MASK");

	if (non_mask) {
		printf("|(COURSE_SCENERY_%s_VAL)<<8", non_mask_vals[id]);
	} else {
		printf("|(COURSE_BG_%s_VAL<<12)", bg[id]);
		printf("|(COURSE_FG_MASK_%d_VAL<<8)", mask_id);
	}

	printf(")\n");
}

static const char *obj_b[] = {
	"ROPE_NORM",
	"ROPE_PLAT",
	"CASTLE",
	"STAIRS",
	"PIPE_EXIT",
	"POLE_TIP",
#ifdef	SMB2M
	"C470",
	"C475"
#endif
};

static void print_F(int pos_x)
{
	int c;
	int new_page;
	unsigned int id, dimension;

	c = getchar();
	new_page = (c & 0x80);
	id = (c & 0x70) >> 4;
	dimension = (c & 0xF) + 1;

	if (new_page)
		printf("\n");

	printf("\t.word\t(COURSE_SCENERY_TYPE_F|COURSE_SCENERY_POS_X_%X", pos_x);

	if (new_page)
		printf("|COURSE_SCENERY_NEW_PAGE");
	
	printf("|COURSE_OBJ_B_%s", obj_b[id]);
	printf("|COURSE_OBJ_DIM_%d", dimension);

	printf(")\n");
}

static const char *obj[] = {
	"PIPE_VERT_A",
	"LEDGE",
	"BRICKROW",
	"FLOORROW",
	"COINROW",
	"BRICKCOL",
	"FLOORCOL",
	"PIPE_VERT_B"
};

static const char *obj_c[] = {
	"BLOCK_Q_A",
	"BLOCK_Q_B",
	"BLOCK_Q_C",
#ifdef	SMB2
	"BLOCK_Q_D",
	"BLOCK_Q_F",
	"BLOCK_ITEM_E",
#endif
#ifdef	SMB2M
	"BLOCK_Q_E",
#endif
	"HIDDEN_ONE_UP",
	"BLOCK_ITEM_A",
	"BLOCK_ITEM_B",
	"BLOCK_ITEM_C",
	"BLOCK_ITEM_D",
	"BLOCK_COIN",
	"PIPE_WATER",
	"EMPTY_DRAW",
	"SPRING"
};

static void print_norm(int pos_x, int pos_y)
{
	int c;
	int new_page;
	int is_norm;
	int is_downpipe;
	unsigned int id, dimension;

	c = getchar();
	new_page = (c & 0x80);
	is_downpipe = (c & 0x78) == 0x78;
	is_norm = (c & 0x70);
	id = is_norm ? ((c & 0x70) >> 4) : (c & 0xF);

	if (is_downpipe) {
		dimension = (c & 0x7);
	} else if (is_norm) {
		dimension = (c & 0xF);
	} else {
		dimension = 0;
	}
	dimension++;

	if (new_page)
		printf("\n");

	printf("\t.word\t(COURSE_SCENERY_POS_Y_%.1X|COURSE_SCENERY_POS_X_%.1X", pos_y, pos_x);

	if (new_page)
		printf("|COURSE_SCENERY_NEW_PAGE");

	if (is_downpipe) {
		printf("|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK");
		printf("|COURSE_OBJ_DIM_%d", dimension);
	} else if (is_norm) {
		printf("|COURSE_OBJ_%s", obj[id]);
		printf("|COURSE_OBJ_DIM_%d", dimension);
	} else {
		printf("|COURSE_OBJ_C_%s", obj_c[id]);
	}

	printf(")\n");
}
