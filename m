Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70E36A03A
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876589; cv=none; b=tNWVf92aiFmtOo97UmR5NkB+9XFsh0Q8xIX87wIViG5EZbbDZe2356jqh5mNncHTPmnRJbsPpXsOg5zV8rXPt6BQZzlT96s2jgqVs0ikwUkozkd7h999DTkUASZRfJ/MlQAUAkF6d+heIMsSYnw6KzzILszrgbfx5/EnpQ1TBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876589; c=relaxed/simple;
	bh=mZCNK66vBelnbXAKKZf6XRyyWPauOn6BKeo/gMgWL3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quaF4i9NCDtXIeXlk4X2JIYT4etEGUaJOSXZNcNA6ylXMCP/tYJPIRrcfZRhqiFqOFX0BNJyE63fJoGb7iAGqAKP0NbDZLzsj/o0njJMGcQ2gyX1WK/2AK2QWUb1fM11EsIYe1VvRX0d/fUG3sngdgtYne/KVYmwOFdKKjtB1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=BuINmbQB; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="BuINmbQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1762876586; bh=mZCNK66vBelnbXAKKZf6XRyyWPauOn6BKeo/gMgWL3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuINmbQBP0ZUmhdv+skCV7dEkv2fyOtdPYhvdHDj1xQwmabBPlrmnKsOB1in73l3q
	 jNPYOwqqY2b6CmdXtxuX7Tu0+wKFc3hand7G1VIvHUwkGDS25dSoeXKJdK2GJjWoVa
	 hruJZiOXkPl7dMPz/9QGmJqLFKiZFWS3Lq8MTslYkimfsED+E1iz+Rgat1xQ4JGec5
	 6f8wzvBlVzhkehzWdgZNvwBASyDW27TflZ913UZsMuKv9OEk8L8e5Jy90IAdoJecO9
	 B3TzjxyQmdcm1z0Q9FsW9Al0hehsBDuS6mZkwC4sD4pN/ekVidnKu66LGiMiy0qAQR
	 ck2IvweNaqk8A==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 48FC71000D4; Tue, 11 Nov 2025 15:56:26 +0000 (GMT)
Date: Tue, 11 Nov 2025 15:56:26 +0000
From: Sean Young <sean@mess.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, Haotian Zhang <vulab@iscas.ac.cn>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [GIT PULL FOR 6.19] Rc fixes
Message-ID: <aRNcqjWG41YvJt48@gofer.mess.org>
References: <aRJOqJF9nJGgBdhO@gofer.mess.org>
 <56d1880e-4483-47e6-8156-235a16f59e8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d1880e-4483-47e6-8156-235a16f59e8d@kernel.org>

Hi Hans,

On Tue, Nov 11, 2025 at 10:14:17AM +0100, Hans Verkuil wrote:
> On 10/11/2025 21:44, Sean Young wrote:
> > Hi Hans, Mauro,
> > 
> > Just some small fixes.
> > 
> > Many thanks,
> > 
> > Sean
> > 
> > The following changes since commit b4fbb13db86adb0bae1d7f968b61ea8dc9635e33:
> > 
> >   media: qcom: camss: Add support for MSM8939 (2025-11-06 12:43:56 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   https://gitlab.freedesktop.org/linux-media/users/seanyoung tags/v6.19a
> 
> Nitpick: this URL is missing the '.git' in 'seanyoung.git'.
> 
> I figured it out, so no need to do anything.

Noted for next time.

Thanks,

Sean

> 
> Regards,
> 
> 	Hans
> 
> > 
> > for you to fetch changes up to 370a7a6e77af43ea949710fd1919b8d6fb2b187e:
> > 
> >   media: siano: Remove redundant ternary operators (2025-11-10 10:42:48 +0000)
> > 
> > ----------------------------------------------------------------
> > v6.19a
> > 
> > ----------------------------------------------------------------
> > Haotian Zhang (1):
> >       media: rc: st_rc: Fix reset control resource leak
> > 
> > Johan Hovold (1):
> >       media: ir-hix5hd2: Drop unused module alias
> > 
> > Liao Yuanhong (1):
> >       media: siano: Remove redundant ternary operators
> > 
> >  drivers/media/common/siano/smsir.c | 2 +-
> >  drivers/media/rc/ir-hix5hd2.c      | 1 -
> >  drivers/media/rc/st_rc.c           | 2 +-
> >  3 files changed, 2 insertions(+), 3 deletions(-)
> > 
