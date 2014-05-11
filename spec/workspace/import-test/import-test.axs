PROGRAM_NAME='import-test'

#include 'import-include'
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvNull			= 0:0:0;
vdvDuet			= 41000:1:0;

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

define_module 'test-module-compiled'	compiled_module();
define_module 'test-module-source'	source_module();
define_module 'duet-lib-pjlink_dr0_1_1'	pj1(vdvDuet);

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
