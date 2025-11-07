Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFF18DF9D
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762491764; cv=none; b=BLFOuAdCQfe/9sdDIJxv7cs2a/MECJc6gpWlbM08t1Sbwv4pCLiXwv5NEYOi3g/kFiB/mtOVDKNZzfyU6yoQi9d9XwuB8+VIy2cunoDG6dsQH/Yhem19VXSVfaqYJVAQuN+dtyJ+x3WhvBzebNalG2OkMLShVgMIjP0JxyUNMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762491764; c=relaxed/simple;
	bh=K/570kVOABpxNWUETUYfvu1aPCwlcAjbLItwdY0GNbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7iHhD1ssLxTHiWMdP05Wecq9Gsv7RE/QaP7FjFILi21me1qrrTSgMzBrAdqnUq+L6KP2OP0oSoZVfMaJz2vfCY5Rtfi2JK6hXVU/c96Adtv95QhKIn0foKEQ7F8ZsRLw2tZ7n5Dd+SwYEuSHOwcYSc7OMc2E5yu/I9wE3S/aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi2O3Jbe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi2O3Jbe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29586626fbeso3284505ad.0
        for <linux-media@vger.kernel.org>; Thu, 06 Nov 2025 21:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762491762; x=1763096562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/570kVOABpxNWUETUYfvu1aPCwlcAjbLItwdY0GNbA=;
        b=Hi2O3Jbeym2bggYPEgZhHaYPJO8vp9OnPJH2gdY9wsxS8z1DKmRcVfLYFmqERYbLVe
         tjhDvHL0Ilcm2TzIYxRhaRd1E+aJsReL45gongHhMqF1YcPP/MTe6GKrYmL8nA6KQ/0F
         KKXEC67nYATTN8QKqYfcAqOONl9zgMAtx7aMixhIQHVfMN87GHwTd4jt4lbeMRQ8aneC
         RXse0Zr539X588niBwAwRDKdpcsdWB/Idq2CdPArBkdK3ry3YyN2JycYm0U0LkgbHctE
         q1paei9Se/tT8e0DBCmnW/x5kBvd/bMtoPziL6CTKfYidPdcCjKkiFvwYF5YYETFiWic
         6mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762491762; x=1763096562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/570kVOABpxNWUETUYfvu1aPCwlcAjbLItwdY0GNbA=;
        b=sLUul2809X9bQZUOQG3Efd99tKvEuP6DOWOJzd4xyk51kiDlvqmPNfdz10Sr640I6G
         HmfaicmKIb2/ggEfCJkLBvrXnZzRrZDfZ9J2mGpVRS6E77kMiZOGot4sk88uMz9aQBMK
         UvMl2xFBfTmRxDfxFrluFIUUE9IH9GgCUQXZ8ypp0Az52a+Rwg2WlxYPv5aU1GQ+l2MR
         0DUwLAMTSw83bu+nds7IwXTO0Bm+Rlb8ho+129rOTkM+nmI3DdPPpXJi4SxL5AotFpgF
         0gTokuhavmfU7zi/mmYAnXg5BxaK71ElutZPPsIJz9cqYABi4kTJ5NyF+qhCSUbWIlEl
         N6sw==
X-Forwarded-Encrypted: i=1; AJvYcCWcVAqkPVFohcMZ7uM8B+hAv1HmE7baPxRgxBbmQEE9inPVct3xP5u+zoAHXBVIZ239g/Wq0WNnRSY3xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwg2w1w+d+ix/mYdbqbI096sWqANHgjXt+xfXESCDBFpeWfOx
	cDehUTqr0SHoLh8x6Bpdv44bvKhCVV1EVEvr9fGET8pICOxnqnKCsOJSXYBgReo89ML9jXL1fZj
	IHsfy7JM8n7pEV7B6DMfMgWxoSJpmQo0=
X-Gm-Gg: ASbGncuRrbjtxpQro51oIe28rL6vlyUaT4ziGtDpbwnyJeXVby8InWJwoalKhPXSiy5
	4W/qYcycLfTp6G/3nL0Dbmzb/Vxy2dIgBG5enxYVYtimadFJy1P7o1EWhTJexZ0dQlOmL3Cf3Hl
	ZjCrplqUVzYlLnvbPxkmO4ZtapOIScnhUBN75Apzp68G83/9v4zji1IYGVUMo3vZ12G/sGhn/8p
	G7VgwTB6pC52jQkKnwvuzxp4Kw+JiGTpra7LvVprCBOyzq0GGctEH6tcF49jnuT1ILoivGnJ9tg
	nuFiVCCGD2qnxmVXJdY=
X-Google-Smtp-Source: AGHT+IFkTy6bthzcml/gWK5hi6r0GHQfrOqeahZZUlgBhv5ohTM7S7Kd0pM2PbsWeWHGExIwfHF7rV3+1BrAdSjcERE=
X-Received: by 2002:a17:902:ecc3:b0:295:9db1:ff4b with SMTP id
 d9443c01a7336-297c03b71c5mr22942675ad.4.1762491762059; Thu, 06 Nov 2025
 21:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101052651.6197-1-opensource206@gmail.com>
 <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
 <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com> <c64985f5-f1e5-4880-876d-0a3c9d83629c@linuxfoundation.org>
In-Reply-To: <c64985f5-f1e5-4880-876d-0a3c9d83629c@linuxfoundation.org>
From: opensource india <opensource206@gmail.com>
Date: Fri, 7 Nov 2025 10:32:31 +0530
X-Gm-Features: AWmQ_bkB1gZgyHljOZHhfX6ld4J6AvQVPtB7Mr_H8pBdlKriiKvm9XNpxJZqZIg
Message-ID: <CAKPKb8830YHuY=h662wPVPvTz3LcyLio6pRDy9ZGStkqwu_Vdg@mail.gmail.com>
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:41=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 11/5/25 22:03, opensource india wrote:
> > Hi Shuah,
> >
> > On Wed, Nov 5, 2025 at 10:43=E2=80=AFPM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> On 10/31/25 23:26, Pavan Bobba wrote:
> >>> Introduce a new vimc-input entity to simulate a color frame source in=
 the
> >>> Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 =
frames
> >>> and allows testing of pipelines that start from a pre-processed RGB/Y=
UV
> >>> source instead of a raw Bayer sensor.
> >>>
> >>> The patch adds vimc-input.c with basic pad operations for format
> >>> enumeration, get/set, and stream enable/disable handlers. The entity =
is
> >>> registered in the VIMC core configuration, replacing the previous tem=
porary
> >>> use of vimc-sensor. Frame generation is not yet implemented and remai=
ns a
> >>> TODO for future work.
> >>>
> >>> This change enables link validation and format negotiation for the
> >>> RGB/YUV input path, paving the way for software frame injection and
> >>> test-pattern generation.
> >>>
> >>> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> >>
> >> I see 4 patches - are they dependent then gerenrate a sries
> >> with cover letter explaining the changes you are making.
> >>
> >> thanks,
> >> -- Shuah
> >
> > even though all 4 patches are part of vimc driver,
> > these are independent patches
>
> Independent in the sense that they can be applied and tested
> independently?

Yes. all 4 patches can be applied and test independently

>
> thanks,
> -- Shuah
>
