Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F9224B0D;
	Mon,  2 Feb 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045957; cv=none; b=mKFqtkKz+ZPZEB/3qQ8kKuolXHhCJ5syS21AJAZNdNPZkdjEz59XDToaBgry3t6GCADDPt78xXf41rsBAeKdKiTY3lwdmyIKyjARHL8ycvgAtwDIrL0NymFiW4VZlILaX/Lj8h2tV8GlLoPYphuU6ETxIr7sBJ78/40XXllAj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045957; c=relaxed/simple;
	bh=DFuO41kU9JE8mVCK3UNH7rCEhdaQ9vq1QONrPhUi+Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhqcPl8r8oLgWlQJTsFQMrnX0wNSGF9RV7/KAzkq3SqDs9Mq7qUZfyEsWqvaa4UnaJNxL55QTIIYa8N5mKmgqfwGbRVb+tQY1iK70GmpM5ozwv/yjT6z0ASmbGSBo99JF8kr04kGLjvl8noz3hqqLQ4QCgfHJaFLtnsGh50aG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Xsoile; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4Xsoile"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5C9C116C6;
	Mon,  2 Feb 2026 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770045957;
	bh=DFuO41kU9JE8mVCK3UNH7rCEhdaQ9vq1QONrPhUi+Dw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B4XsoilejfaHT0+b7fTqKIE7LsU58fphESFljvIK+QkLPte4ZXIWoWlyAfXt+P7ZJ
	 p1rA4GVDYH/zX17Q5N/qFXWqk+0jd49wAB3IOH+m/zomtgFQctZQ1FF2H8kyLyyKPn
	 NDODbhEugRXpUI5qVCVXKvO5jiHohnxi6qLCCXS6egNn2gIORfKuUPwjg5VprSFAwc
	 omB9ndxB67eUhI4oR/H4VICYNxDL6KjKNCLXe+d9c0eMganbDmxgbzJgbTnJl8NW68
	 2EP0vfllqrRyKm0MAbITGnYPI0opgucglLZr+LKUpnP9nEvlk7MOUb4UAUz/Ke5iXu
	 U/XlTUnGSIYBQ==
Message-ID: <90bdef41-f588-4c02-9b9b-4f158a3cc64a@kernel.org>
Date: Mon, 2 Feb 2026 15:25:51 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] media: dt-bindings: Document SC8280XP/SM8350 Venus
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bjorn Andersson <andersson@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260125-iris-sc8280xp-v3-0-d21861a9ea33@oss.qualcomm.com>
 <d6KSmXDteJwEfGyWVdbVo-k0JONslgZlxBYNFBQ7CS2culpbLJhrT3pyf_OWVBAGBdovr8a2UIcVhgEvpiSd7A==@protonmail.internalid>
 <20260125-iris-sc8280xp-v3-1-d21861a9ea33@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <20260125-iris-sc8280xp-v3-1-d21861a9ea33@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/01/2026 15:32, Dmitry Baryshkov wrote:
> +        iommus = <&apps_smmu 0x2100 0x400>;

Is this actually the correct set of iommus ?

Can we check to make sure ?

---
bod
