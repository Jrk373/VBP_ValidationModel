-- This is the code to extract IP Claims data from the HCA data warehouse
-- Updated 5/2/23 by JRK

-- Declare Date Range
Declare @start as date = '01-01-2023'
Declare @end as date = '06-30-2023'

SELECT vos.PrimaryID AS VOS_primaryId
	, id.primaryId AS GM_primaryId
	, id.AzAhcccsId
	, id.BCBSMedicaidId AS MemberID
	, id.lastName
	, id.firstName
	, id.dob
	, id.sex
	, vos.Age
	, vos.MemberZipcode
	, vos.begDate
	, vos.endDate
	, vos.svccode
	, vos.ProcedureCode
	, vos.RevCode
	, vos.Placesvc
	, vos.ProviderType
	, vos.PrimaryDiagnosis
	, vos.Dx1
	, vos.Dx2
	, vos.Dx3
	, vos.Dx4
	, vos.Dx5
	, vos.Dx6
	, vos.Dx7
	, vos.Dx8
	, vos.Dx9
	, vos.Dx10
	, vos.Dx11
	, vos.Dx12
	, vos.ProviderName
	, vos.RenderingProviderNpi
	, vos.PCPName
	, vos.calcnetpd
	, vos.ra

FROM
claims.dbo.shcavos vos
LEFT OUTER JOIN GlobalMembers.dbo.ClientIdPlus id ON vos.primaryId = id.primaryId

WHERE vos.EncounterStatus = 'AP'
AND vos.EncounterStatusDate BETWEEN @start and @end
AND vos.begDate >= @start
AND MemberACCGSA = 'North'
AND vos.svcCode IN ('99357','99356','99255','99254','99253'
				,'99252','99251','99239','99238','99236'
				,'99235','99234','99233','99232','99231'
				,'99222','99221','99220','99219','99218'
				,'99217','92223','0114','0124','0134'
				,'0154','0116','0126','0136','0156','0110'
				,'0111','0112','0113','0120','0121','0122'
				,'0123','0130','0131','0132','0133','0150'
				,'0151','0152','0153','0160','0200','0201'
				,'0202','0203','0206','0209','0210','0115'
				,'0117','0118','0116','0125','0127','0128'
				,'0129','0135','0137','0138','0139','0155'
				,'0157','0158','0159','0164','0167','0163'
				,'0190','0191','0192','0193','0194','0199'
				,'0204','0207','0208','0211','0212','0213'
				,'0214','0219')

GROUP BY vos.PrimaryID
	, id.primaryId
	, id.AzAhcccsId
	, id.BCBSMedicaidId
	, id.lastName
	, id.firstName
	, id.dob
	, id.sex
	, vos.Age
	, vos.MemberZipcode
	, vos.begDate
	, vos.endDate
	, vos.svccode
	, vos.ProcedureCode
	, vos.RevCode
	, vos.Placesvc
	, vos.ProviderType
	, vos.PrimaryDiagnosis
	, vos.Dx1
	, vos.Dx2
	, vos.Dx3
	, vos.Dx4
	, vos.Dx5
	, vos.Dx6
	, vos.Dx7
	, vos.Dx8
	, vos.Dx9
	, vos.Dx10
	, vos.Dx11
	, vos.Dx12
	, vos.ProviderName
	, vos.RenderingProviderNpi
	, vos.PCPName
	, vos.primaryDiagnosis
	, calcnetpd
	, vos.ra