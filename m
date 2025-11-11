Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F727AC4C
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852461; cv=none; b=BpYGLpzXjBwVRvSZ/IuePIUiCPAEzSE/hnw4LVGlFt4dmtk3e7nopLNiC7xgd8l0C069XgRCGOYK0EhV9n43Ym4Eu79Dd3UZPQDh1g4aNniwCicQVCRBGruk/v9HWazVkzosFSliPHeHnzGyi4sO/usFhotZStJXcBJv78wCKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852461; c=relaxed/simple;
	bh=miAQPZx7qYL9sHCwbKEhqXvyXB3+aC78GmbmLlV0W1M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oO+FBeFHWjtj/Pkoj/j/v2Cb5JZYkqM0Yhbn99oF2zVBBiyVEKvqsLuWS/uAhxOABFGgEj4upN8FAPCOGF5KD9p2oC2h1yHaEMntoApa8eOSIl9COP5MsXOoSjOxkPRQY9uUXjBJKz6U+cfaakpxEG36mmqOeno/LPc1VeH3hdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcCBFGGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcCBFGGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0805C4CEFB;
	Tue, 11 Nov 2025 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762852460;
	bh=miAQPZx7qYL9sHCwbKEhqXvyXB3+aC78GmbmLlV0W1M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=BcCBFGGeQeOykcC3+JITVxHptj84+rgbeS4EzfdU3dyUjUUsbreTbBZ/TA5uzfy7W
	 zxO+/tQbbCK8T6+nPZBgY8+lf0u44hIkQzGhIrQwLbvxUkae+jA/g0hUJGG/xGuaRZ
	 2zm4CblYnx4viGZ4kJSp/j7qc7jsk3E3UTptMDUUjyKzAjzOjcYyL/pbxjHtDEnnSF
	 XSOhyq5c53ZwKSlcKgVILH0vn89qU/IQpjb2M49ORopXtbG7mzhKjz3VkjnpJsMAiG
	 2ocIqinnI2LL7AayAJsDe1jv0SVa+mffsc46Dnl0CHy4vepNOqNmlCy8KoYpAAO+OZ
	 tTQFJKWAoypJQ==
Message-ID: <56d1880e-4483-47e6-8156-235a16f59e8d@kernel.org>
Date: Tue, 11 Nov 2025 10:14:17 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [GIT PULL FOR 6.19] Rc fixes
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org
Cc: Haotian Zhang <vulab@iscas.ac.cn>, Liao Yuanhong <liaoyuanhong@vivo.com>,
 Johan Hovold <johan@kernel.org>
References: <aRJOqJF9nJGgBdhO@gofer.mess.org>
Content-Language: en-US, nl
In-Reply-To: <aRJOqJF9nJGgBdhO@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2025 21:44, Sean Young wrote:
> Hi Hans, Mauro,
> 
> Just some small fixes.
> 
> Many thanks,
> 
> Sean
> 
> The following changes since commit b4fbb13db86adb0bae1d7f968b61ea8dc9635e33:
> 
>   media: qcom: camss: Add support for MSM8939 (2025-11-06 12:43:56 +0100)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/linux-media/users/seanyoung tags/v6.19a

Nitpick: this URL is missing the '.git' in 'seanyoung.git'.

I figured it out, so no need to do anything.

Regards,

	Hans

> 
> for you to fetch changes up to 370a7a6e77af43ea949710fd1919b8d6fb2b187e:
> 
>   media: siano: Remove redundant ternary operators (2025-11-10 10:42:48 +0000)
> 
> ----------------------------------------------------------------
> v6.19a
> 
> ----------------------------------------------------------------
> Haotian Zhang (1):
>       media: rc: st_rc: Fix reset control resource leak
> 
> Johan Hovold (1):
>       media: ir-hix5hd2: Drop unused module alias
> 
> Liao Yuanhong (1):
>       media: siano: Remove redundant ternary operators
> 
>  drivers/media/common/siano/smsir.c | 2 +-
>  drivers/media/rc/ir-hix5hd2.c      | 1 -
>  drivers/media/rc/st_rc.c           | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 

