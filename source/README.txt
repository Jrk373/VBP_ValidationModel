This is the Source folder.

Store all code things here. This could include:
- R Scripts
- SQL Scripts
- Markdown files
- Notebooks

Files in this folder:

1. FUH_IP_Claims.sql - the sql code to extract data for IP Claims
2. FUH_FU_Claims.sql - the sql code to extract data for FU Claims
3. IP Claims import - the R code used to import the raw claims data to the VBPMeasurementValidation model. This is the same as the code used in the VBPMeasurementValidation report.
4. VBP_import - the R code used to import the VBP Qulaity report data to the VBPMeasurementValidation model. This is the same as the code used in the VBPMeasurementValidation report.
5. Validation_FUH7 - the R code that validates VBP against claims data

* Together, these 5 sets of code extract the VBP and IPClaims data from theier source, clean it, and use it to validate VBP eligible events against actual adjudicated claims. *

** The code in the "VBPMeasurementValidation" report is always the most up to date.**


6. DxGroupings - the R code used to seperate claims into BX diagnostic groupings. This is the same as the code used in the VBPMeasurementValidation report.


Files for the Follow Up Lists
7. FUH_FollowUp_GapList


