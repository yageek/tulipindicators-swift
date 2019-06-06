/*
 * tulipindicators-swfit
 * https://tulipindicators.org/
 * Copyright (c) 2019 Yannick Heinrich
 * Yannick Heinrich (me@yageek.net)
 *
 * This file is part of tulipindicators-swfit.
 *
 * Tulip Indicators is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 *
 * Tulip Indicators is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
 * for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Tulip Indicators.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef __TULIP_WRAPPING
#define __TULIP_WRAPPING

struct ti_indicator_info;
extern struct ti_indicator_info *ti_indicators_ptr;

char **ti_indicator_info_get_input_names(struct ti_indicator_info *info);
char **ti_indicator_info_get_option_names(struct ti_indicator_info *info);
char **ti_indicator_info_get_output_names(struct ti_indicator_info *info);
#endif
