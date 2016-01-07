----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
-- CDM.v3 Bootstrap Script
-- MSSQL version
-- Author(s): Jiang Bian (bianjiang@ufl.edu)
-- Based on: https://github.com/SCILHS/i2p-transform/blob/master/MSSQL/PCORNetLoader.sql
-- V0.02: Add UPDATED and SOURCE columns to each table; HARVEST table does have these two columns as well. Up for discussion
-- V0.01: (BOOTSTRAPED FROM PCORNET CDM excel specs)
--    - unique constraint is not enforced;
--    - FK is not enforced;
--    - required is ignored (as it's equivalent to  not null )
-- INSTRUCTIONS:
-- 0. 
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

-- Change to your pmn database
USE ONEFLDW
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ENROLLMENT]') AND type in (N'U'))
DROP TABLE [dbo].[ENROLLMENT]
GO
CREATE TABLE [dbo].[ENROLLMENT](
    [PATID] VARCHAR(50) NOT NULL,
    [ENR_START_DATE] DATETIME NOT NULL,
    [ENR_END_DATE] DATETIME,
    [CHART] VARCHAR(1),
    [ENR_BASIS] VARCHAR(1) NOT NULL,
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PATID] ASC,
    [ENR_START_DATE] ASC,
    [ENR_BASIS] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRO_CM]') AND type in (N'U'))
DROP TABLE [dbo].[PRO_CM]
GO
CREATE TABLE [dbo].[PRO_CM](
    [PRO_CM_ID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ENCOUNTERID] VARCHAR(50),
    [PRO_ITEM] VARCHAR(7) NOT NULL,
    [PRO_LOINC] VARCHAR(10),
    [PRO_DATE] DATETIME NOT NULL,
    [PRO_TIME] VARCHAR(5),
    [PRO_RESPONSE] NUMERIC(8) NOT NULL,
    [PRO_METHOD] VARCHAR(2),
    [PRO_MODE] VARCHAR(2),
    [PRO_CAT] VARCHAR(2),
    [RAW_PRO_CODE] VARCHAR(50),
    [RAW_PRO_RESPONSE] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PRO_CM_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VITAL]') AND type in (N'U'))
DROP TABLE [dbo].[VITAL]
GO
CREATE TABLE [dbo].[VITAL](
    [VITALID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ENCOUNTERID] VARCHAR(50),
    [MEASURE_DATE] DATETIME NOT NULL,
    [MEASURE_TIME] VARCHAR(5),
    [VITAL_SOURCE] VARCHAR(2) NOT NULL,
    [HT] NUMERIC(8),
    [WT] NUMERIC(8),
    [DIASTOLIC] NUMERIC(4),
    [SYSTOLIC] NUMERIC(4),
    [ORIGINAL_BMI] NUMERIC(8),
    [BP_POSITION] VARCHAR(2),
    [SMOKING] VARCHAR(2),
    [TOBACCO] VARCHAR(2),
    [TOBACCO_TYPE] VARCHAR(2),
    [RAW_DIASTOLIC] VARCHAR(50),
    [RAW_SYSTOLIC] VARCHAR(50),
    [RAW_BP_POSITION] VARCHAR(50),
    [RAW_SMOKING] VARCHAR(50),
    [RAW_TOBACCO] VARCHAR(50),
    [RAW_TOBACCO_TYPE] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [VITALID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ENCOUNTER]') AND type in (N'U'))
DROP TABLE [dbo].[ENCOUNTER]
GO
CREATE TABLE [dbo].[ENCOUNTER](
    [ENCOUNTERID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ADMIT_DATE] DATETIME NOT NULL,
    [ADMIT_TIME] VARCHAR(5),
    [DISCHARGE_DATE] DATETIME,
    [DISCHARGE_TIME] VARCHAR(5),
    [PROVIDERID] VARCHAR(50),
    [FACILITY_LOCATION] VARCHAR(3),
    [ENC_TYPE] VARCHAR(2) NOT NULL,
    [FACILITYID] VARCHAR(50),
    [DISCHARGE_DISPOSITION] VARCHAR(2),
    [DISCHARGE_STATUS] VARCHAR(2),
    [DRG] VARCHAR(3),
    [DRG_TYPE] VARCHAR(2),
    [ADMITTING_SOURCE] VARCHAR(2),
    [RAW_SITEID] VARCHAR(50),
    [RAW_ENC_TYPE] VARCHAR(50),
    [RAW_DISCHARGE_DISPOSITION] VARCHAR(50),
    [RAW_DISCHARGE_STATUS] VARCHAR(50),
    [RAW_DRG_TYPE] VARCHAR(50),
    [RAW_ADMITTING_SOURCE] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [ENCOUNTERID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEATH_CAUSE]') AND type in (N'U'))
DROP TABLE [dbo].[DEATH_CAUSE]
GO
CREATE TABLE [dbo].[DEATH_CAUSE](
    [PATID] VARCHAR(50) NOT NULL,
    [DEATH_CAUSE] VARCHAR(8) NOT NULL,
    [DEATH_CAUSE_CODE] VARCHAR(2) NOT NULL,
    [DEATH_CAUSE_TYPE] VARCHAR(2) NOT NULL,
    [DEATH_CAUSE_SOURCE] VARCHAR(2) NOT NULL,
    [DEATH_CAUSE_CONFIDENCE] VARCHAR(2),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PATID] ASC,
    [DEATH_CAUSE] ASC,
    [DEATH_CAUSE_CODE] ASC,
    [DEATH_CAUSE_TYPE] ASC,
    [DEATH_CAUSE_SOURCE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CONDITION]') AND type in (N'U'))
DROP TABLE [dbo].[CONDITION]
GO
CREATE TABLE [dbo].[CONDITION](
    [CONDITIONID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ENCOUNTERID] VARCHAR(50),
    [REPORT_DATE] DATETIME,
    [RESOLVE_DATE] DATETIME,
    [ONSET_DATE] DATETIME,
    [CONDITION_STATUS] VARCHAR(2),
    [CONDITION] VARCHAR(18) NOT NULL,
    [CONDITION_TYPE] VARCHAR(2) NOT NULL,
    [CONDITION_SOURCE] VARCHAR(2) NOT NULL,
    [RAW_CONDITION_STATUS] VARCHAR(50),
    [RAW_CONDITION] VARCHAR(50),
    [RAW_CONDITION_TYPE] VARCHAR(50),
    [RAW_CONDITION_SOURCE] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [CONDITIONID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRESCRIBING]') AND type in (N'U'))
DROP TABLE [dbo].[PRESCRIBING]
GO
CREATE TABLE [dbo].[PRESCRIBING](
    [PRESCRIBINGID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ENCOUNTERID] VARCHAR(50),
    [RX_PROVIDERID] VARCHAR(50),
    [RX_ORDER_DATE] DATETIME,
    [RX_ORDER_TIME] VARCHAR(5),
    [RX_START_DATE] DATETIME,
    [RX_END_DATE] DATETIME,
    [RX_QUANTITY] NUMERIC(8),
    [RX_REFILLS] NUMERIC(8),
    [RX_DAYS_SUPPLY] NUMERIC(8),
    [RX_FREQUENCY] VARCHAR(2),
    [RX_BASIS] VARCHAR(2),
    [RXNORM_CUI] NUMERIC(8),
    [RAW_RX_MED_NAME] VARCHAR(50),
    [RAW_RX_FREQUENCY] VARCHAR(50),
    [RAW_RXNORM_CUI] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PRESCRIBINGID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LAB_RESULT_CM]') AND type in (N'U'))
DROP TABLE [dbo].[LAB_RESULT_CM]
GO
CREATE TABLE [dbo].[LAB_RESULT_CM](
    [LAB_RESULT_CM_ID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ENCOUNTERID] VARCHAR(50),
    [LAB_NAME] VARCHAR(10),
    [SPECIMEN_SOURCE] VARCHAR(10),
    [LAB_LOINC] VARCHAR(10),
    [PRIORITY] VARCHAR(2),
    [RESULT_LOC] VARCHAR(2),
    [LAB_PX] VARCHAR(11),
    [LAB_PX_TYPE] VARCHAR(2),
    [LAB_ORDER_DATE] DATETIME,
    [SPECIMEN_DATE] DATETIME,
    [SPECIMEN_TIME] VARCHAR(5),
    [RESULT_DATE] DATETIME NOT NULL,
    [RESULT_TIME] VARCHAR(5),
    [RESULT_QUAL] VARCHAR(12),
    [RESULT_NUM] NUMERIC(8),
    [RESULT_MODIFIER] VARCHAR(2),
    [RESULT_UNIT] VARCHAR(11),
    [NORM_RANGE_LOW] VARCHAR(10),
    [NORM_MODIFIER_LOW] VARCHAR(2),
    [NORM_RANGE_HIGH] VARCHAR(10),
    [NORM_MODIFIER_HIGH] VARCHAR(2),
    [ABN_IND] VARCHAR(2),
    [RAW_LAB_NAME] VARCHAR(50),
    [RAW_LAB_CODE] VARCHAR(50),
    [RAW_PANEL] VARCHAR(50),
    [RAW_RESULT] VARCHAR(50),
    [RAW_UNIT] VARCHAR(50),
    [RAW_ORDER_DEPT] VARCHAR(50),
    [RAW_FACILITY_CODE] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [LAB_RESULT_CM_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HARVEST]') AND type in (N'U'))
DROP TABLE [dbo].[HARVEST]
GO
CREATE TABLE [dbo].[HARVEST](
    [NETWORKID] VARCHAR(10) NOT NULL,
    [NETWORK_NAME] VARCHAR(20),
    [DATAMARTID] VARCHAR(10) NOT NULL,
    [DATAMART_NAME] VARCHAR(20),
    [DATAMART_PLATFORM] VARCHAR(2),
    [CDM_VERSION] NUMERIC(8),
    [DATAMART_CLAIMS] VARCHAR(2),
    [DATAMART_EHR] VARCHAR(2),
    [BIRTH_DATE_MGMT] VARCHAR(2),
    [ENR_START_DATE_MGMT] VARCHAR(2),
    [ENR_END_DATE_MGMT] VARCHAR(2),
    [ADMIT_DATE_MGMT] VARCHAR(2),
    [DISCHARGE_DATE_MGMT] VARCHAR(2),
    [PX_DATE_MGMT] VARCHAR(2),
    [RX_ORDER_DATE_MGMT] VARCHAR(2),
    [RX_START_DATE_MGMT] VARCHAR(2),
    [RX_END_DATE_MGMT] VARCHAR(2),
    [DISPENSE_DATE_MGMT] VARCHAR(2),
    [LAB_ORDER_DATE_MGMT] VARCHAR(2),
    [SPECIMEN_DATE_MGMT] VARCHAR(2),
    [RESULT_DATE_MGMT] VARCHAR(2),
    [MEASURE_DATE_MGMT] VARCHAR(2),
    [ONSET_DATE_MGMT] VARCHAR(2),
    [REPORT_DATE_MGMT] VARCHAR(2),
    [RESOLVE_DATE_MGMT] VARCHAR(2),
    [PRO_DATE_MGMT] VARCHAR(2),
    [REFRESH_DEMOGRAPHIC_DATE] DATETIME,
    [REFRESH_ENROLLMENT_DATE] DATETIME,
    [REFRESH_ENCOUNTER_DATE] DATETIME,
    [REFRESH_DIAGNOSIS_DATE] DATETIME,
    [REFRESH_PROCEDURES_DATE] DATETIME,
    [REFRESH_VITAL_DATE] DATETIME,
    [REFRESH_DISPENSING_DATE] DATETIME,
    [REFRESH_LAB_RESULT_CM_DATE] DATETIME,
    [REFRESH_CONDITION_DATE] DATETIME,
    [REFRESH_PRO_CM_DATE] DATETIME,
    [REFRESH_PRESCRIBING_DATE] DATETIME,
    [REFRESH_PCORNET_TRIAL_DATE] DATETIME,
    [REFRESH_DEATH_DATE] DATETIME,
    [REFRESH_DEATH_CAUSE_DATE] DATETIME,
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [NETWORKID] ASC,
    [DATAMARTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PROCEDURES]') AND type in (N'U'))
DROP TABLE [dbo].[PROCEDURES]
GO
CREATE TABLE [dbo].[PROCEDURES](
    [PROCEDURESID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ENCOUNTERID] VARCHAR(50) NOT NULL,
    [ENC_TYPE] VARCHAR(2),
    [ADMIT_DATE] DATETIME,
    [PROVIDERID] VARCHAR(50),
    [PX_DATE] DATETIME,
    [PX] VARCHAR(11) NOT NULL,
    [PX_TYPE] VARCHAR(2) NOT NULL,
    [PX_SOURCE] VARCHAR(50),
    [RAW_PX] VARCHAR(50),
    [RAW_PX_TYPE] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PROCEDURESID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DISPENSING]') AND type in (N'U'))
DROP TABLE [dbo].[DISPENSING]
GO
CREATE TABLE [dbo].[DISPENSING](
    [DISPENSINGID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [PRESCRIBINGID] VARCHAR(50),
    [DISPENSE_DATE] DATETIME NOT NULL,
    [NDC] VARCHAR(11) NOT NULL,
    [DISPENSE_SUP] NUMERIC(8),
    [DISPENSE_AMT] NUMERIC(8),
    [RAW_NDC] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [DISPENSINGID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEMOGRAPHIC]') AND type in (N'U'))
DROP TABLE [dbo].[DEMOGRAPHIC]
GO
CREATE TABLE [dbo].[DEMOGRAPHIC](
    [PATID] VARCHAR(50) NOT NULL,
    [BIRTH_DATE] DATETIME,
    [BIRTH_TIME] VARCHAR(5),
    [SEX] VARCHAR(2),
    [HISPANIC] VARCHAR(2),
    [RACE] VARCHAR(2),
    [BIOBANK_FLAG] VARCHAR(1),
    [RAW_SEX] VARCHAR(50),
    [RAW_HISPANIC] VARCHAR(50),
    [RAW_RACE] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PATID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIAGNOSIS]') AND type in (N'U'))
DROP TABLE [dbo].[DIAGNOSIS]
GO
CREATE TABLE [dbo].[DIAGNOSIS](
    [DIAGNOSISID] VARCHAR(50) NOT NULL,
    [PATID] VARCHAR(50) NOT NULL,
    [ENCOUNTERID] VARCHAR(50) NOT NULL,
    [ENC_TYPE] VARCHAR(2),
    [ADMIT_DATE] DATETIME,
    [PROVIDERID] VARCHAR(50),
    [DX] VARCHAR(18) NOT NULL,
    [DX_TYPE] VARCHAR(2) NOT NULL,
    [DX_SOURCE] VARCHAR(2) NOT NULL,
    [PDX] VARCHAR(2),
    [RAW_DX] VARCHAR(50),
    [RAW_DX_TYPE] VARCHAR(50),
    [RAW_DX_SOURCE] VARCHAR(50),
    [RAW_PDX] VARCHAR(50),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [DIAGNOSISID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEATH]') AND type in (N'U'))
DROP TABLE [dbo].[DEATH]
GO
CREATE TABLE [dbo].[DEATH](
    [PATID] VARCHAR(50) NOT NULL,
    [DEATH_DATE] DATETIME NOT NULL,
    [DEATH_DATE_IMPUTE] VARCHAR(2),
    [DEATH_SOURCE] VARCHAR(2) NOT NULL,
    [DEATH_MATCH_CONFIDENCE] VARCHAR(2),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PATID] ASC,
    [DEATH_DATE] ASC,
    [DEATH_SOURCE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PCORNET_TRIAL]') AND type in (N'U'))
DROP TABLE [dbo].[PCORNET_TRIAL]
GO
CREATE TABLE [dbo].[PCORNET_TRIAL](
    [PATID] VARCHAR(50) NOT NULL,
    [TRIALID] VARCHAR(20) NOT NULL,
    [PARTICIPANTID] VARCHAR(50) NOT NULL,
    [TRIAL_SITEID] VARCHAR(50),
    [TRIAL_ENROLL_DATE] DATETIME,
    [TRIAL_END_DATE] DATETIME,
    [TRIAL_WITHDRAW_DATE] DATETIME,
    [TRIAL_INVITE_CODE] VARCHAR(20),
    [UPDATED] DATETIME NOT NULL DEFAULT GETDATE(),
    [SOURCE] VARCHAR(50) NOT NULL,
PRIMARY KEY CLUSTERED
(
    [PATID] ASC,
    [TRIALID] ASC,
    [PARTICIPANTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO