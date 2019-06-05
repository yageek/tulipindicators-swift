#ifndef __TULIP_WRAPPING
#define __TULIP_WRAPPING

struct ti_indicator_info;
extern struct ti_indicator_info *ti_indicators_ptr;

char **ti_indicator_info_get_input_names(struct ti_indicator_info *info);
char **ti_indicator_info_get_option_names(struct ti_indicator_info *info);
char **ti_indicator_info_get_output_names(struct ti_indicator_info *info);
#endif
