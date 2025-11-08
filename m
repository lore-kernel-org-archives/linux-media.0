Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AB1F4CB3
	for <linux-media@vger.kernel.org>; Sat,  8 Nov 2025 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642401; cv=none; b=c2u8CqZabkoi/csv2cYCLxJsPna0wEt5wUFKHp55koaeOhsudNem63YCCie2QJ4Nl4xDu0rjidJt97t/3WFMV+OzMMD00gDYjPSVc+5rTHHPjBLuXPxTs7TB+sqyOsXuQH7sk2OH0zNcKLKEqrmjJM7lTKzQq8YkLhtI0YixXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642401; c=relaxed/simple;
	bh=cYjb2iVHarMvaoPkzkdkwuhVCkis7i+WP7D2iZOrHFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNbTYYv9gsnUGx7Ih023JcDZYs94DwgnzypJstgl5epY+bJjr2u3wcyH7j3q+Qv/Wvz1wRNH4rCUF6PjrkB6QAElrO+6wl/kUAU2VVCjKPcnAp/RM+RB7bVljAMf8XwLZd5/eMqR8ztBKg5KYxVW/kHqQveQ/rJEe/9GOfNLGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cwH3ec3I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cwH3ec3I"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297ec50477aso3360545ad.1
        for <linux-media@vger.kernel.org>; Sat, 08 Nov 2025 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762642399; x=1763247199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woeNf9SnFDKMh9COMO6hWAKnDrWNbFGLLR+aeDPR/i8=;
        b=cwH3ec3I0DPWU4NpsN1WhhhEzCAzZwVZoG84W9Pyh8rXCv99O4Xk86QrgIsLEW86M0
         m8vZELuDNL7NdRSBwsXL1JF6aL1gZdie4RuP0Oau0X524f0XiwgLs5unPxJnablDy4y5
         zygSOR+PVRgAKcgb4plaFRZ7MVqhf2Qxt8JDDF2s534Ijg6TnzrZKuchzhMh8HfPz1Ji
         zMTWzBUabExVjEMs0t7ai/34oQNcCVaDit2gbjEEccbCfj0d8uDka7hD2UVdFKkJYSTD
         Hk/eq30EJceks1zueLS7eNK+/pXXVE+0BNP3WjrbI9tCk6OHKEhwLK11HzgFejzXHwwU
         TUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642399; x=1763247199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woeNf9SnFDKMh9COMO6hWAKnDrWNbFGLLR+aeDPR/i8=;
        b=dNVGRyH3miZZ8IUJ5KdjTlIwO8+e+IbKSaq8YhJuH7CfeUKZtWycINa3Q8dnkaMdDs
         g+7S4yoQkMZIJpbgvnQ2kO5GhvWKbrVkNkU1pfdH2winGhNOc/T1KqHay+aH9mWyOPOY
         d3rJBdh5r+RcG4ao++fEWNyq3dWn3xsCKZPmz3UBGddgjy/1042ov4PhmS1rg1rZ4O+H
         vp4NnlHO3LsR0Vg3vLcnBzYJ51ba0CFhQy99ZjlyTa2bfpRaUQHYJCkNK8Ffy6P/dPQq
         OjNUMOOAu0agHb0/poaHtFW8pa/VJze8NW7Di9u8ASsTy87Xj3BdU7vqzf273J+ISAvr
         JgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEl+Zl2Bcwk/wHQjrPOTGASmvAjzwXJOC0+wvb8F9Ljp/TtfTMjnhbrzEFQ2Bx9wT1/aIOp+yR6mu7lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoSqLh2oxyKAt7TsHrYK18NOQBQ97ehx+5RXpHTl0g7ETMJHA
	+0IB+InzuzJ9Qwf7NtrwlzhpIkfGpdZgQ+LNttdEpcwMxyzLIV+cdVB6zN/tyHcfx+7sA26QAd/
	jj4xNB3J5u9WBKKlb9lDNQGchWtO11D8=
X-Gm-Gg: ASbGncvwK6h+TMJyHWzqo+lGcrFIYUzJqPwqwEQqQLK+/4NKyq/QQ5GctIazysdxzS7
	xieyFyC2D6kJO/xvi2D5fIGJl4c1su4u4r7AktJuoRf8Q1vUnEGNoB8x5tK0HLJ/9GmXrsf+8LJ
	hyin6dZL64+podZYkMasZx5IasR2+s271DiAWUcUSj6LwqY+LqFEVoXsLmhKaI7AjTjk4OnLd+l
	+26hvF6xTNAOxsmSMMyS9GErxlecMheZdpLXxTI7wlKA1SIdgx30pKTCU1ysZUwPw8ohKKUFZUc
	z2HIfefcvyGm+OdQGoiKSnSykKN0
X-Google-Smtp-Source: AGHT+IG+/PJGnDmxUNMI7+aZcN60vo2SoWlora4RSCXqNkbJIUjbFrzUdNRAqKB5MSZuajIzoZgImhzbTKgTAYjlkVM=
X-Received: by 2002:a17:903:37cf:b0:295:134:9ae5 with SMTP id
 d9443c01a7336-297e1e61caamr46129275ad.24.1762642398835; Sat, 08 Nov 2025
 14:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com> <20251027-b4-s4-vdec-upstream-v1-3-620401813b5d@amlogic.com>
In-Reply-To: <20251027-b4-s4-vdec-upstream-v1-3-620401813b5d@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 8 Nov 2025 23:53:07 +0100
X-Gm-Features: AWmQ_bni7l89RyP8uXpthsz3XoYRD2BT1Es7uRWB0DG1y_IRoUhPm173lpNSDGc
Message-ID: <CAFBinCBy7vPq0oX0PQ=yC5E3Mx3sv6qdVHsMh-NQQzAkbDuvRQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] decoder: Add V4L2 stateless H.264 decoder driver
To: zhentao.guo@amlogic.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

thank you for your work on this!

On Mon, Oct 27, 2025 at 6:42=E2=80=AFAM Zhentao Guo via B4 Relay
<devnull+zhentao.guo.amlogic.com@kernel.org> wrote:
[...]
+/**
+ * enum aml_power_type_e - Type of decoder power.
+ */
+enum aml_power_type_e {
+       AML_PM_PD =3D 0,
+};
Are there any other power types that you are already aware of - or is
this added "just in case" an additional type is needed in future?

> +/**
> + * struct gate_switch_node - clock node definition
> + * @clk: Pointer to clk instance.
> + * @name: Clock name used.
> + * @mutex: Mutex lock for multi decoder instance.
> + * @ref_count: Curr clk instance ref count.
> + */
> +struct gate_switch_node {
> +       struct clk *clk;
> +       const char *name;
> +       struct mutex mutex;
> +       int ref_count;
> +};
Generally I'm not sure if the whole struct is needed as I think the
common clock framework has everything we need.
There's struct clk_bulk_data which allows mapping clocks from
device-tree to an array in the code.

drivers/staging/media/starfive/camss/stf-camss.h for defines an enum
(stf_clk) to access each of the clocks by it's index in the array.
You even seem to have an enum (clk_type_e) which you could use to
simplify the code.

My understanding is that one can call clk_prepare_enable() and
clk_disable_unprepare() as often as you'd like and these functions
will do the ref-counting internally.
So I think the ref_count is not explicitly needed, as that's managed
by the common clock framework.


Best regards,
Martin
