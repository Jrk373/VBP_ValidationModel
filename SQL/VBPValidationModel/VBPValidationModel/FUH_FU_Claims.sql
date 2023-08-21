-- This is the code to extract FU Claims data from the HCA data warehouse
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
-- FU Codes
AND vos.svcCode IN ('90791','90792','90832','90833','90834'
				,'90836','90837','90838','90839','90840'
				,'90845','90847','90849','90853','90870'
				,'90875','90876','98960','98961','98962'
				,'98966','98967','98968','98969','98970'
				,'98971','98972','99078','99201','99202'
				,'99203','99204','99205','99211','99212'
				,'99213','99214','99215','99217','99218'
				,'99219','99220','99221','99222','99223'
				,'99231','99232','99233','99238','99239'
				,'99241','99242','99243','99244','99245'
				,'99251','99252','99253','99254','99255'
				,'99341','99342','99343','99344','99345'
				,'99347','99348','99349','99350','99381'
				,'99382','99383','99384','99385','99386'
				,'99387','99391','99392','99393','99394'
				,'99395','99396','99397','99401','99402'
				,'99403','99404','99411','99412','99421'
				,'99422','99423','99441','99442','99443'
				,'99444','99457','99483','99492','99493'
				,'99494','99495','99496','99510','G0071'
				,'G0155','G0176','G0177','G0409','G0410'
				,'G0411','G0463','G0512','G2010','G2012'
				,'G2061','G2062','G2063','H0002','H0004'
				,'H0031','H0034','H0035','H0036','H0037'
				,'H0039','H0040','H2000','H2001','H2010'
				,'H2011','H2012','H2013','H2014','H2015'
				,'H2016','H2017','H2018','H2019','H2020'
				,'S0201','S9480','S9484','S9485','T1015')

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