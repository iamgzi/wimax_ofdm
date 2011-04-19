`include "common_widths.v"

module vect();
/* Page 633
 * Modulation mode: QPSK, rate 3/4, Symbol Number within burst: 1, UIUC: 7,
 * BSID: 1, Frame Number 1 (decimal values)
 */

parameter uiuc = 7;
parameter bsid = 1;
parameter frame_num = 1;

parameter input_data_sz = 560;
reg [0:input_data_sz-1] input_data =      560'h45_29_C4_79_AD_0F_55_28_AD_87_B5_76_1A_9C_80_50_45_1B_9F_D9_2A_88_95_EB_AE_B5_2E_03_4F_09_14_69_58_0A_5D;

reg [0:input_data_sz-1] randomized_data = 560'hD4_BA_A1_12_F2_74_96_30_27_D4_88_9C_96_E3_A9_52_B3_15_AB_FD_92_53_07_32_C0_62_48_F0_19_22_E0_91_62_1A_C1;


parameter rs_data_sz = input_data_sz + 8 * 5;
reg [0:rs_data_sz-1] rs_encoded_data =       'h49_31_40_BF_D4_BA_A1_12_F2_74_96_30_27_D4_88_9C_96_E3_A9_52_B3_15_AB_FD_92_53_07_32_C0_62_48_F0_19_22_E0_91_62_1A_C1_00;

parameter cc_data_sz = 3 * rs_data_sz / 4; // rs_data_sz + 8*8;
reg [0:cc_data_sz-1] cc_encoded_data =       'h3A_5E_E7_AE_49_9E_6F_1C_6F_C1_28_BC_BD_AB_57_CD_BC_CD_E3_A7_92_CA_92_C2_4D_BC_8D_78_32_FB_BF_DF_23_ED_8A_94_16_27_A5_65_CF_7D_16_7A_45_B8_09_CC;

reg [0:cc_data_sz-1] inteinterleaved_data =  'h77_FA_4F_17_4E_3E_E6_70_E8_CD_3F_76_90_C4_2C_DB_F9_B7_FB_43_6C_F1_9A_BD_ED_0A_1C_D8_1B_EC_9B_30_15_BA_DA_31_F5_50_49_7D_56_ED_B4_88_CC_72_FC_5C;

/*
Subcarrier mapping (frequency offset index: I value Q value)
-100: 1 -1, -99: -1 -1, -98: 1 -1, -97: -1 -1, -96: -1 -1, -95: -1 -1, -94: -1 1, -93: -1 1, -92: 1 -1, -91: 1
1, -90: -1 -1, -89: -1 -1, -88:pilot= 1 0, -87: 1 1, -86: 1 -1, -85: 1 -1, -84: -1 -1, -83: 1 -1, -82: 1 1, -81:
-1 -1, -80: -1 1, -79: 1 1, -78: -1 -1, -77: -1 -1, -76: -1 1, -75: -1 -1, -74: -1 1, -73: 1 -1, -72: -1 1, -71:
1 -1, -70: -1 -1, -69: 1 1, -68: 1 1, -67: -1 -1, -66: -1 1, -65: -1 1, -64: 1 1, -63:pilot= -1 0, -62: -1 -1,
-61: 1 1, -60: -1 -1, -59: 1 -1, -58: 1 1, -57: -1 -1, -56: -1 -1, -55: -1 -1, -54: 1 -1, -53: -1 -1, -52: 1 -1,
-51: -1 1, -50: -1 1, -49: 1 -1, -48: 1 1, -47: 1 1, -46: -1 -1, -45: 1 1, -44: 1 -1, -43: 1 1, -42: 1 1,
-41: -1 1, -40: -1 -1, -39: 1 1, -38:pilot= 1 0, -37: -1 -1, -36: 1 -1, -35: -1 1, -34: -1 -1, -33: -1 -1,
-32: -1 -1, -31: -1 1, -30: 1 -1, -29: -1 1, -28: -1 -1, -27: 1 -1, -26: -1 -1, -25: -1 -1, -24: -1 -1,
-23: -1 1, -22: -1 -1, -21: 1 -1, -20: 1 1, -19: 1 1, -18: -1 -1, -17: 1 -1, -16: -1 1, -15: -1 -1, -14: 1 1,
-13:pilot= -1 0, -12: -1 -1, -11: -1 -1, -10: 1 1, -9: 1 -1, -8: -1 1, -7: 1 -1, -6: -1 1, -5: -1 1, -4: -1 1,
-3: -1 -1, -2: -1 -1, -1: 1 -1, 0: 0 0, 1: -1 -1, 2: -1 1, 3: -1 -1, 4: 1 -1, 5: 1 1, 6: 1 1, 7: -1 1, 8: -1 1, 9:
1 1, 10: 1 -1, 11: -1 -1, 12: 1 1, 13:pilot= 1 0, 14: -1 -1, 15: 1 -1, 16: -1 1, 17: 1 1, 18: 1 1, 19: 1 -1,
20: -1 1, 21: -1 -1, 22: -1 -1, 23: -1 1, 24: -1 -1, 25: 1 1, 26: -1 1, 27: 1 -1, 28: -1 1, 29: -1 -1, 30: 1 1,
31: -1 -1, 32: 1 1, 33: 1 1, 34: 1 1, 35: 1 -1, 36: 1 -1, 37: 1 -1, 38:pilot= 1 0, 39: -1 1, 40: -1 -1, 41: -1
1, 42: -1 1, 43: -1 -1, 44: 1 -1, 45: -1 1, 46: -1 1, 47: 1 1, 48: -1 -1, 49: 1 1, 50: 1 -1, 51: -1 -1, 52: -1
-1, 53: 1 -1, 54: 1 -1, 55: 1 -1, 56: 1 -1, 57: 1 1, 58: 1 1, 59: 1 -1, 60: 1 1, 61: -1 1, 62: 1 -1, 63:pilot=
1 0, 64: 1 -1, 65: -1 -1, 66: -1 -1, 67: 1 -1, 68: 1 -1, 69: 1 -1, 70: 1 -1, 71: -1 1, 72: -1 -1, 73: -1 1, 74:
-1 -1, 75: 1 -1, 76: -1 1, 77: -1 -1, 78: 1 -1, 79: 1 1, 80: -1 1, 81: 1 1, 82: -1 1, 83: 1 1, 84: -1 -1, 85: 1
1, 86: -1 -1, 87: 1 1, 88:pilot= 1 0, 89: 1 -1, 90: -1 -1, 91: 1 1, 92: -1 1, 93: -1 -1, 94: -1 -1, 95: -1 -1,
96: 1 1, 97: 1 -1, 98: 1 -1, 99: -1 -1, 100: 1 1
*/

endmodule
