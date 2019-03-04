#ifndef __c3_barrier_template_14a_h__
#define __c3_barrier_template_14a_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc3_barrier_template_14aInstanceStruct
#define typedef_SFc3_barrier_template_14aInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c3_sfEvent;
  uint8_T c3_tp_q0;
  uint8_T c3_tp_q10;
  uint8_T c3_tp_q11;
  uint8_T c3_tp_q12;
  uint8_T c3_tp_q13;
  uint8_T c3_tp_q14;
  uint8_T c3_tp_q15;
  uint8_T c3_tp_q16;
  uint8_T c3_tp_q17;
  uint8_T c3_tp_q18;
  uint8_T c3_tp_q19;
  uint8_T c3_tp_q2;
  uint8_T c3_tp_q20;
  uint8_T c3_tp_q21;
  uint8_T c3_tp_q22;
  uint8_T c3_tp_q23;
  uint8_T c3_tp_q24;
  uint8_T c3_tp_q3;
  uint8_T c3_tp_q4;
  uint8_T c3_tp_q5;
  uint8_T c3_tp_q6;
  uint8_T c3_tp_q7;
  uint8_T c3_tp_q8;
  uint8_T c3_tp_q9;
  boolean_T c3_isStable;
  boolean_T c3_doneDoubleBufferReInit;
  uint8_T c3_is_active_c3_barrier_template_14a;
  uint8_T c3_is_c3_barrier_template_14a;
  uint8_T c3_doSetSimStateSideEffects;
  const mxArray *c3_setSimStateSideEffectsInfo;
} SFc3_barrier_template_14aInstanceStruct;

#endif                                 /*typedef_SFc3_barrier_template_14aInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c3_barrier_template_14a_get_eml_resolved_functions_info
  (void);

/* Function Definitions */
extern void sf_c3_barrier_template_14a_get_check_sum(mxArray *plhs[]);
extern void c3_barrier_template_14a_method_dispatcher(SimStruct *S, int_T method,
  void *data);

#endif
