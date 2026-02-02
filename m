Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B533A029;
	Mon,  2 Feb 2026 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023152; cv=none; b=VEOhgBUmkptneYi4FDsAPjSjugOaBcRbFCgiSklpOD/VCY+8Ituike520/5SEXamAX6EoAiajhA34GcHTMj8Lp2INBYZQNL8NN40dVsOr7Dba47cBDcV1pAEbChBxH+emPJoJ/paN8kD7o7+NhZf/Qaa3FTgfmFi1YS91Ey11FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023152; c=relaxed/simple;
	bh=WtroFsQn4+1gRHCnyVeCu5RypXl1fF2jLiojNp47JUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqMidyR+bvOueRhRzfLLVOzbdbdkP1uzCMU4BN9knDkiZ31etIaW7FOI48cgspHzrmPWR8voGRHirYWkzW0n8DjlZ2v1xtxBC765pKCU4a+IFdf2AuNNOU1suLzXgmhAHwOvyy6EIdvs/b9K0Dg2hGorqWqNWv0zIUKVc+Mbx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ps15s4dl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps15s4dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8422EC116C6;
	Mon,  2 Feb 2026 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770023151;
	bh=WtroFsQn4+1gRHCnyVeCu5RypXl1fF2jLiojNp47JUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ps15s4dldUI8blOwn3BlIoajbywt2bICQ99S5wbHvozLPZ4j3CW0GK/qnHrCmUiY0
	 wsDYJYA45XskAgUwg5b+MHqEjsi2MQmqRPHGRi43jpJofSb8iYAH3pzkI/kPOcw77v
	 M2NfvHRquc7hJS8W0sGOZMdEF2qToDIXVSASUIWIrIAzhUfgDAapjD+9s+XmRWNNEz
	 oK0APPuBV/UTi8302jKKcbbp1PQLxUsTm+gnbIAXBMdw6Dz3Zh3aQdJ5hdRc63hwqu
	 5mpgV/M/x65j9ME0a6p+9WEyl/L0nmNgUWh4sBnlod/1JLdAtc/zBholcIdAR6BI2p
	 SoG17VP5cmg5A==
Date: Mon, 2 Feb 2026 11:05:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
	anisse@astier.eu, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <aYBo69zrMnRdWs32@kernel.org>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <5073898.31r3eYUQgx@natalenko.name>
 <20260202001704.2419778a@foz.lan>
 <13939245.uLZWGnKmhe@natalenko.name>
 <20260202020214.2243acec@foz.lan>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202020214.2243acec@foz.lan>

On Mon, Feb 02, 2026 at 02:02:14AM +0100, Mauro Carvalho Chehab wrote:
> On Mon, 02 Feb 2026 00:25:37 +0100
> Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> 
> > Date: Mon, 02 Feb 2026 00:25:37 +0100
> > From: Oleksandr Natalenko <oleksandr@natalenko.name>
> > To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jarkko Sakkinen <jarkko@kernel.org>, linux-media@vger.kernel.org, jani.nikula@linux.intel.com, anisse@astier.eu, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Ricardo Ribalda <ribalda@chromium.org>, open list <linux-kernel@vger.kernel.org>
> > Message-ID: <13939245.uLZWGnKmhe@natalenko.name>
> > 
> > On pondělí 2. února 2026 0:17:20, středoevropský standardní čas Mauro Carvalho Chehab wrote:
> > > No. At the machine with the camera, obs can read from a V4L2 input,
> > > generate a mpeg TS stream, and listen to a UDP port (for instance). 
> > > 
> > > At the remote machine, you can just pass the URL to ffmpeg.  
> > 
> > I can't, I have to feed the stream into Firefox somehow for it to see the stream as a virtual webcam.
> 
> Motioneye could be used on such scenario. It has a proper web
> interface, allows multiple users to watch, has login control accepts
> multiple cameras.

When proposed workarounds move in the area of motion detection systems
it feels like there was a competion who invents the most impractical
solution for a practical real-world problem out in the wild.

> 
> Thanks,
> Mauro

BR, Jarkko
