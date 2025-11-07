Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B262F6578
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480708; cv=none; b=HS0JxEnO8QlXcS1gxZJWwzWv6EnTobyz3/4rG33qSPpGziMtDG/snELao/1yYRSAn8PyPYcNxFfIT5QzoPdpK3crfALsxDgA7sJ13zqjGz5D+V/LZY2hNrQsgLwdNy02la31hexJf8KRSYWW6ZK4pTFh0nBwv2rbB+KFrEgWHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480708; c=relaxed/simple;
	bh=pwPuTGj6ibesmxBx/TI3wDvbDrZilqkPMgs75aqDyZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRayjwqTbDgaFiTSU8T5UG2li3ssrXVgpZsJNpNPtP4acxYEIGMLcKACXE0GPBYFIi5rJRs21xTNyfY2dAZLlHj20Fie87WIuW4NQBBR2Hz0k8Oza72AK1Wm0em+XpIP+hMVEjA3iYe0g3oW105N2WeNGvGI885NC70TsHyt2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NfjRyFPZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NfjRyFPZ"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 91F25122A;
	Fri,  7 Nov 2025 02:56:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762480582;
	bh=pwPuTGj6ibesmxBx/TI3wDvbDrZilqkPMgs75aqDyZY=;
	h=From:To:Cc:Subject:Date:From;
	b=NfjRyFPZVJY4BhXbwKElJ4rJ87cuMR9TjGdXko7msGRXIP8wgqe4AnLQzJ/5TD+kq
	 V1lgGgp12hocDWKXgE+HgbK66tGHKmn7ZzwOUdmyGuGCtKvf+9tewcaYoPFTQpGZQ8
	 zXI1U5uwtV00JeZt91wFokjdaFlFt/yctSPq4jdM=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v1 0/6] media: imx-mipi-csis: Add streams support
Date: Fri,  7 Nov 2025 03:58:07 +0200
Message-ID: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The reference manual for the NXP i.MX7D in which the CSIS is integrated
lists four outputs named "channels" in various diagrams and tables, but 
only documents registers for channel 0. Reference manuals for i.MX8 SoCs
that integrate the CSIS gradually removed mentions of channels 1 to 3 as
newer revisions of the documents got released, which was interpreted as
an indication that the CSIS has only a single output.

That interpretation turned out not to be correct. In the i.MX8MP, the
CSIS features multiple output channels. Channel 0 is connected to the
ISI, and channels 0, 1 and 2 are connected to the ISP. Multi-channel
support towards the ISP is meant to support HDR, where camera sensors
transmit multiple exposures or gains over different virtual channels.
The glue logic between the CSIS and ISP hardcodes this use case and
combines the channels in a way suitable for the ISP's single input port.

With a time machine, we would probably redesign the CSIS DT bindings to
model each output channel with a port, and the V4L2 subdev would use
multiple source pads. Without a time machine, we need to preserve
backward compatibility with userspace. Not only would the addition of
new ports and pads make this tricky, they would also require modelling
the glue logic between the CSIS and ISP with a subdev. This would
conflict with the need to preserve backward compatibility.

Fortunately for us, the CSIS is an old IP. The NXP i.MX9 series uses a
different CSI-2 receiver, and the probability of needing to support an
SoC that connects different output channels to different devices is
extremely low. We can therefore implement a solution tailored to the
needs of the i.MX8MP, and model the output channels as separate streams
instead of separate pads. Should the need arise in the future to support
connecting output channels to different devices in a new SoC, we will
still be able to model this with extra ports in the device tree without
breaking backward compatibility. The driver could then create extra
subdev pads accordingly.

The series starts with 5 preparatory patches to ease review. Patch 1/6
adds missing register definitions. Patch 2/6 then switches from
.s_stream() to .enable_streams() and .disable_streams(), a pre-requisite
for multi-stream support. Patch 3/6 follows by implementing the
.s_routing() operation, supporting a single route exactly as done
implicitly so far. Patches 4/6 and 5/6 refactor the code to group
parameters in structures and clean up how they are written to registers.
Finally, patch 6/6 adds multi-channel support.

The series has been tested on an i.MX8MP with libcamera, both without
changes to verify that backward compatibility is preserved, and with HDR
support (work still in progress) to verify that VC filtering works as
expected.

Laurent Pinchart (6):
  media: imx-mipi-csis: Add VC-related register fields
  media: imx-mipi-csis: Switch to .enable_streams()
  media: imx-mipi-csis: Implement the .set_routing() operation
  media: imx-mipi-csis: Group runtime parameters in structure
  media: imx-mipi-csis: Set all per-channel registers in one function
  media: imx-mipi-csis: Add multi-channel support

 drivers/media/platform/nxp/imx-mipi-csis.c | 551 ++++++++++++++++-----
 1 file changed, 429 insertions(+), 122 deletions(-)


base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
Regards,

Laurent Pinchart

