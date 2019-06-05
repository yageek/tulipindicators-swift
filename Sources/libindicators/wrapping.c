#include "indicators.h"

struct ti_indicator_info *ti_indicators_ptr = &ti_indicators[0];

char **ti_indicator_info_get_input_names(struct ti_indicator_info *info) {
    return &info->input_names[0];
}

char **ti_indicator_info_get_option_names(struct ti_indicator_info *info){
    return &info->option_names[0];
}

char **ti_indicator_info_get_output_names(struct ti_indicator_info *info){
    return &info->output_names[0];
}
