/*
 * File: GEN_Func_fu.c
 *
 * MATLAB Coder version            : 3.1
 * C/C++ source code generated on  : 21-Jan-2018 01:36:29
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "ParNMPC.h"
#include "GEN_Func_fu.h"
#include <stdio.h>
#include "omp.h"
#include "stdio.h"

/* Function Definitions */

/*
 * GEN_FUNC_FU
 *     FU = GEN_FUNC_FU(IN1,IN2)
 * Arguments    : const double in1[15]
 *                double fu[12]
 * Return Type  : void
 */
void GEN_Func_fu(const double in1[15], double fu[12])
{
  double t2;
  double t3;
  double t4;
  double t6;
  double t13;
  double x[12];

  /*     This function was generated by the Symbolic Math Toolbox version 7.0. */
  /*     21-Jan-2018 01:32:02 */
  t2 = cos(in1[9] - in1[10]);
  t3 = cos(in1[9]);
  t4 = cos(in1[10]);
  t6 = t2 * t2;
  t13 = 1.0 / ((((t3 * t3 * 972.0 + t4 * t4 * 345.0) + t6 * 1035.0) - t2 * t3 *
                t4 * 810.0) - 2116.0);
  x[0] = 0.0;
  x[1] = 0.0;
  x[2] = 0.0;
  x[3] = t13 * (t6 * 90000.0 - 184000.0) * 0.00020833333333333329;
  x[4] = t13 * (t3 * 24000.0 - t2 * t4 * 10000.0) * 0.00625;
  x[5] = t13 * (t4 * 46000.0 - t2 * t3 * 54000.0) * 0.0027777777777777779;
  x[6] = 0.0;
  x[7] = 0.0;
  x[8] = 0.0;
  x[9] = 0.0;
  x[10] = 0.0;
  x[11] = 0.0;
  memcpy(&fu[0], &x[0], 12U * sizeof(double));
}

/*
 * File trailer for GEN_Func_fu.c
 *
 * [EOF]
 */