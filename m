Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE425308F3A
	for <linux-media@vger.kernel.org>; Sun,  9 Nov 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708975; cv=none; b=eowPGs45v3BwFbO77CCJvN7gS6QguZEWFfymfNDPMxG+oizjyHIWE0eaU/FJOcMy+rnmfr0zhsX3yfhOjGJBmtvCY/4u8QqlmH1PnlPyILOyMeza2rgFsfkDr09n2jjPrRE49qL6Yca445t4Blj1A+IC357xzwxIYQbzlohbwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708975; c=relaxed/simple;
	bh=8xrRb4Ja7YDYCikqkpnM1+9xLkErGoSE0Ilyg3K603U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cJlyVXm5QLNN6k3Y7SD9cPc/2PXk3hxRuILiihKoXVu23fclMKT4Hg2SPqaCK5Ei4WInq8OVa/uGqoosXQREqvVUwvoPCVK/sfEzzKo6cGH47a9WC2MR6XChGYnG5npM2hIfhzZZWwPGJ1KQdnqcISWagMf/dq7JhCRxwpOK5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=tlf32Vm4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="tlf32Vm4"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso3659099a12.0
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762708972; x=1763313772; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7u5viM8iOHpulamZW8Yl5pjwnfS/F/QVQpeIUIajsE=;
        b=tlf32Vm4NVrasKbkE996+Mj6XQVE03iUa6BZr/4GVFSrrOzf3ZgZdS0WAMnZw++XHF
         wPAmk7eAJNPJSm8b9OfBtOjhyVHnYWFl+Q78i/d/WyVjXGOcMz8PNpar9PYBq6dP0+aa
         el5n5PPNIQpi4CSO92ADIdilnEVstRU2D/PH8dmGQYeVO/PVWP/yVAjg+U3kAlyB2wqR
         xHHRnazDTd7x3VviVzdyGH1a/mQw6NJ/xm6RJ70TGzKyYI+EdfBPb3G9VRzTLgfcVfLo
         7GKfazWZWyc/lEa0gNbGh6VeOLO/TB9YDYIo2I/UxD1zTGmnqCtIJrJHkJFF5pB2+Nll
         2/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762708972; x=1763313772;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7u5viM8iOHpulamZW8Yl5pjwnfS/F/QVQpeIUIajsE=;
        b=gxxABf7Hg6sOa+QqvSpTsFZlpYDqkSuJFxfbegru5OEC2GWHm+Ut017eyToXU9y19o
         LlwTVrlpPkIXfhrAvQATZH+hURuQHjPloJCFkFahnkhLqTyC08sJKSaVsV53a8WuVodo
         ed5jh9K4tNgk9PtXKzTlpUlkgRIEAxKqROM6tg1BKMVVnQdSAyE+siXZXaRfPvqvE/aU
         EnYo4NQs+W75Ta5/OJQGGi/v+ieVCGlaEqjKr0DWpYXNR9C1N+KnG7y8r5wbcLyYNixJ
         l/f80yoUMpORj1Ek1nhIY/xU87mbj/y+mKqLNyXwTtADr0OoNfTcCsPVI7SfFl81O4RQ
         JoJg==
X-Forwarded-Encrypted: i=1; AJvYcCUAei5zpl0c5/yM6qUk/JlSzfyzOS02g8uk641OiPQmbIqdWFw3DarjWMsOYz2R2yPDcjCwRlX8w2Yctw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmV1vrLkKj5m+eqmr0m7Qx5fVyii57Kbc2eBhR9Xb9PrsfmwI
	vw9wtiW6pEBW7yuiiBrsrLVL/uJc28yGee7cb50bRc5aAGrYSnlAqNCJWeczMkDn/Bg=
X-Gm-Gg: ASbGncvsr0esiyQdCg95sQPmPmbrPLBv8tdIjBOqGrJBauZpy2Ww7D0XzHVmg/Y6oQ7
	hopESpWOKyEkmqG/HcNlkRwCMfCZSuDTDI1G4252wY4E62tXq/U2rgdfzIKZHMpP1sQOy1zAnYe
	u5dbDMLQ+u0/lHusvhq5qAtaeUogcMCdl1crsbvJWOCdTp5loRIZw4SZu3rYm+Nj2LqLsA8WbkA
	nHO3miNyt2fFcXVzxD0VF85u5R/23MkeYQXNYtljDrM9y+Agtwu8WQ0oPdhoqbrcA45CeYshx+q
	4Auwv429L/O7fCjXRGz+yoxgK4OsI/o3yiZhP7RijeHn4GGaGIO/2X73vt9xFph+ZxvROqZ4YdK
	mON2Kwm0Trlp6kDRfY2QtYkE8TdwsZCwEG1wMgTVU4sDWxyoCRcVubC9KVBUfC3I0sjSFSGPSHv
	bnTmPAZ4Sc6hFgMa8ebQKAQyhpmIG6KOILC6Rx0T5nl81dSgazgsJjksoI2YO3GZ0YGMkEuGCl4
	7xyw9dEoyhIm3abX2E1DdAfNGHaTGzd+Vk=
X-Google-Smtp-Source: AGHT+IHiNx88guNnogcxy/ePccl6T4u99WrAa4tO6dTyzZ7pWo9gTArz9LqZTlbTuW3AfvNrVuFznA==
X-Received: by 2002:a05:6402:3546:b0:640:f974:7629 with SMTP id 4fb4d7f45d1cf-6415dc205e6mr4941873a12.15.1762708971341;
        Sun, 09 Nov 2025 09:22:51 -0800 (PST)
Received: from localhost (2001-1c00-3b8a-ea00-c4de-d39d-05f4-c77a.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:c4de:d39d:5f4:c77a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415d91f486sm4786157a12.22.2025.11.09.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 09:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Nov 2025 18:22:50 +0100
Message-Id: <DE4C6HV76V5M.1I1NJB2JCK1LN@fairphone.com>
Cc: "Joel Selvaraj" <foss@joelselvaraj.com>, <linux-media@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <phone-devel@vger.kernel.org>
Subject: Re: [PATCH RFC 8/8] media: qcom: camss: Remove D-PHY-only endpoint
 restriction
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <david@ixit.cz>, "Robert Foss" <rfoss@kernel.org>, "Todor Tomov"
 <todor.too@gmail.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 "Vladimir Zapolskiy" <vladimir.zapolskiy@linaro.org>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 "Petr Hodina" <phodina@protonmail.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>
In-Reply-To: <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>

On Sun Nov 9, 2025 at 10:39 AM CET, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> C-PHY mode is now supported, so the endpoint bus-type restriction to
> D-PHY can be removed.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/media/platform/qcom/camss/camss.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/pl=
atform/qcom/camss/camss.c
> index 248aa6b21b5ad..1408e8a03f0bd 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4044,15 +4044,6 @@ static int camss_of_parse_endpoint_node(struct dev=
ice *dev,
>  	if (ret)
>  		return ret;
> =20
> -	/*
> -	 * Most SoCs support both D-PHY and C-PHY standards, but currently only
> -	 * D-PHY is supported in the driver.
> -	 */
> -	if (vep.bus_type !=3D V4L2_MBUS_CSI2_DPHY) {

How about just adding && !=3D V4L2_MBUS_CSI2_CPHY to it? Good to check in
any case imo.

Regards
Luca

> -		dev_err(dev, "Unsupported bus type %d\n", vep.bus_type);
> -		return -EINVAL;
> -	}
> -
>  	csd->interface.csiphy_id =3D vep.base.port;
> =20
>  	mipi_csi2 =3D &vep.bus.mipi_csi2;

