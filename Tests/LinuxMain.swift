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
 
import XCTest

import tulipindicatorsTests

var tests = [XCTestCaseEntry]()
tests += tulipindicatorsTests.allTests()
XCTMain(tests)
