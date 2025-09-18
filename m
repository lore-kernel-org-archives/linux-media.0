Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D178F59;
	Thu, 18 Sep 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196909; cv=none; b=Q3RzEixpPLNIINV6BTN1ATYXrWMmDY1/So7VTK8VsaZYBpfYPMpKHu5pc1Ohtqh6EWhHssoAfllZ3cfn4mvXxRpIumgl9uAstzeXE3EwdBZ9ZMu6hVrAhfHKMJg3RvcN+2vwRFBRx4HN2QOdTt7XaAULMs6XJBYBxRKtUx2Jles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196909; c=relaxed/simple;
	bh=v9ef4nig/yfccKeAJEpJSA9wWCx0vUtghQ9jBLfY9mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=la9azZOdSEkFmRNC+93S8HiAgCiHCbZyO8zAneA6Zxb7YZ8pclRlh9B0XnMsbs5NNBL+1tyvMrkk3NgJYChBFg9gC+w/AlT+h6oo7207pLMmOJIhHK+pEZE/mlqdl8M2RGHaBwV3HMjCTjBlxvAL+l1DSFrWWhNRwxpenNRP4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LPENl4dC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LPENl4dC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBE51v018235;
	Thu, 18 Sep 2025 12:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jhMIYoKWvCUeHJHXrv1GXj
	gmb2V30bjN+YqRF48XxGc=; b=LPENl4dCyv17ldgTH5X7Qsn6B/ezlrELSSWI38
	VGIOfsap0KqWRKsfoaJyUtqWdles3ehVDcMneotBBIKj1yghsQoOljKv3Q2TyCvd
	YfwOobQK27cq6TBJvXrTSNd4H/h6k7lUuGRvdcDmicGog4TGNcuFxXSeWeBmJlA5
	vIJQ0twpDw6cH+sqGakebdJVIMwHXKlI3AwL7WLKqaP73wWCrCHDhKXCcR6yrs5u
	V11CL1x/3AIVELMDkn18JhMV57rMcQVV3UCvRMuluGodJeCmlzEhYBUJDKvG5O20
	9RIc30WEoR5SPf2qcJ+B7pPFa/AxzSfwpFhVYGg330GX+t2Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwe6u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 12:01:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58IC1hsS011256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 12:01:43 GMT
Received: from hu-renjiang-sha.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 05:01:40 -0700
From: Renjiang Han <quic_renjiang@quicinc.com>
Date: Thu, 18 Sep 2025 17:31:08 +0530
Subject: [PATCH v3] media: venus: pm_helpers: add fallback for the
 opp-table
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-fallback_of_opp_table-v3-1-f07b34eb7b3a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIP0y2gC/3XOwU7DMAwG4FepciYocbtk3Yn3QKhyHIdFdE1JS
 gWa9u6k6wUOO/6/5c++isI5chGn5ioyr7HENNXQPjWCzji9s4y+ZgEKDqrXRxlwHB3Sx5DCkOZ
 5WNCNLF1ANh0RalSi7s6ZQ/y+u69vNZ9jWVL+uZ9Z9dbuooX2gbhqqSUoNGBt8J79y+dXpDjRM
 6WL2MwV/jrdIwc2J5DRATplPf13bvuzmWtb4rJ/LBwWlnV+icupQQYPStUz1ng49i0ThgAH71p
 vOfS6V0jKmYrdfgHoVmZUUAEAAA==
X-Change-ID: 20250918-fallback_of_opp_table-bfae64cca1a0
To: <quic_qiweil@quicinc.com>, <quic_wangaow@quicinc.com>,
        Vikash Garodia
	<vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal
	<dikshita.agarwal@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Hans Verkuil
	<hverkuil@kernel.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>,
        Renjiang Han
	<quic_renjiang@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758196899; l=3078;
 i=quic_renjiang@quicinc.com; s=20241001; h=from:subject:message-id;
 bh=v9ef4nig/yfccKeAJEpJSA9wWCx0vUtghQ9jBLfY9mA=;
 b=6ZKoJ8sXbdGDLC1Fe3v5gSbZyHZUcSonIuID3w+9gqg7qCF95uKpW5NBuCfK2ETaq5NYiQFB+
 ITJ7YO3RgHKDqQXi4BfQhYBnNq8dSK/Za65tghOBkz3DavcYCeTRTy+
X-Developer-Key: i=quic_renjiang@quicinc.com; a=ed25519;
 pk=8N59kMJUiVH++5QxJzTyHB/wh/kG5LxQ44j9zhUvZmw=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cbf4a8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=PqXIcnxwrCKdjwSptJ0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8VQDAt792iSH
 bwcOlK2S0VkaQ5nJw7WOrOKGtgiDHB8E9ITSULDcBLvUpQZ1HlAyNZp2aHKPQjbBzb2lxjr3Fnd
 xM2Lktbc+0EMEgDLaKv62Oc/BJx3T8Y2OD3JzOIOghbwTQBZoOMpy1n4Igf49ncOvkKDoZQyScA
 +4hbWn7xZkWdJzPPjSpXJplIu4fz989ubdmvd1TY6P14NSZKAmRDW/kH8Hkf2L+uURs4K/ZhAM6
 uQK260Hz3riwmwu50aPhgi6aF4UoIiA8Y6Jjc98gr0zXDoJRJuCtlHZZ73CpXQMOsReqZaEjmZ6
 NMK9hZIK/W9Dhe8qHoNCjnvBs+s8QbGvDlWV8znlcqiCZKBWAOnI9AXw7o9bsUbF08gWHwiO9UP
 0KnhNfcs
X-Proofpoint-GUID: gYL2dE6YZchjX0oGHgkGatNSYLOI4XIo
X-Proofpoint-ORIG-GUID: gYL2dE6YZchjX0oGHgkGatNSYLOI4XIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Since the device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX
do not include an opp-table and have not configured opp-pmdomain, they
still need to use the frequencies defined in the driver's freq_tbl.

Both core_power_v1 and core_power_v4 functions require core_clks_enable
function during POWER_ON. Therefore, in the core_clks_enable function,
if calling dev_pm_opp_find_freq_ceil to obtain the frequency fails,
it needs to fall back to the freq_tbl to retrieve the frequency.

Fixes: b179234b5e59 ("media: venus: pm_helpers: use opp-table for the frequency")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Closes: https://lore.kernel.org/linux-media/CA+G9fYu5=3n84VY+vTbCAcfFKOq7Us5vgBZgpypY4MveM=eVwg@mail.gmail.com
Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
---
Since device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX do not
contain an opp-table and have not configured opp-pmdomain, they still
need to use the frequencies defined in the driver's freq_tbl.

Therefore, if calling dev_pm_opp_find_freq_ceil to obtain the frequency
fails in the core_clks_enable, it needs to fall back to the freq_tbl to
retrieve the frequency.

Validated this series on QCS615 and msm8916.
---
Changes in v3:
- 1. Fix patch conflict issue.
- Link to v2: https://lore.kernel.org/r/20250724-fallback_of_opp_table-v2-1-2fc61f2407dc@quicinc.com

Changes in v2:
- 1. Update the returned error value as per the feedback.
- Link to v1: https://lore.kernel.org/r/20250723-fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 88618378129a086274b61be5b23410783b92ca26..f0269524ac70eb72384a06aa6a215e2046abf5c2 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -40,6 +40,8 @@ static int core_clks_get(struct venus_core *core)
 
 static int core_clks_enable(struct venus_core *core)
 {
+	const struct freq_tbl *freq_tbl = core->res->freq_tbl;
+	unsigned int freq_tbl_size = core->res->freq_tbl_size;
 	const struct venus_resources *res = core->res;
 	struct device *dev = core->dev;
 	unsigned long freq = 0;
@@ -48,8 +50,13 @@ static int core_clks_enable(struct venus_core *core)
 	int ret;
 
 	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-	if (!IS_ERR(opp))
+	if (IS_ERR(opp)) {
+		if (!freq_tbl)
+			return -ENODEV;
+		freq = freq_tbl[freq_tbl_size - 1].freq;
+	} else {
 		dev_pm_opp_put(opp);
+	}
 
 	for (i = 0; i < res->clks_num; i++) {
 		if (IS_V6(core) || (IS_V4(core) && is_lite(core))) {

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-fallback_of_opp_table-bfae64cca1a0

Best regards,
-- 
Renjiang Han <quic_renjiang@quicinc.com>

