Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2250481FB9
	for <linux-media@vger.kernel.org>; Wed, 21 Jan 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003807; cv=none; b=nkt29ntGNkdfAMspD+NsNdnWl5CZ/cvzpMVrcpq/8Hg/kkuL0VR6lFewQ+UuyrQJ5EP9fFrN76wPclC4oQ7zApsfHrlcDIQTq46DKN/r8cdF6bvISr5qehsBniXd6HInCPibwUOZlsuNQGMcNKdW0PZaETrs2C95PY252LUQnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003807; c=relaxed/simple;
	bh=Yx9d+72s+3PAs53j871MkFNTMAXeIK1rMQQP5/r8Bm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zph/9NsYEI4kXFZPn8iIcs3tG5NljjKis5E2A0KuS7yYD6QiVUagjEWRfuKCnHLzPsBr9VZtmN2QP8Acd8CA8/lO7rx41OKUqizHE79P4eBlQeB/vb3+aZLD/9Rml6kSc3WiVfvE9+lBycbC0U71cvzhRGrWxKS+c+gQ4zXdvtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H8UzsxhU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H8UzsxhU"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c6d8751c88so33002585a.2
        for <linux-media@vger.kernel.org>; Wed, 21 Jan 2026 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769003804; x=1769608604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Avz0zhItUvROQy3aeBayHRvtD6/6o32+NQiPJhA08ug=;
        b=H8UzsxhUFbFGHNp9wMFiBbuYWaCHVH2tYwneO0Wwkd/2zjLrtAazD6c43qjJ4gEjxL
         2OI3Z96r7eB+SIXEJ+CuZ0nhSzPH1EPa7kb6Y1LsJMfBuoD/UDEaqYUa+v638b+Y3GtX
         VTLnqZoBwiOMdp3DMAqilhMtU7u4WTiRlNIcuyh0bwJA813FiqgOyoFwK1Mf5ru/8tTB
         Pa4XV9l/KcTNjw66f9eNHjqvAupeQ3OVFXmo1KKBgvmbcajT+Uo9fCbyXhChBXSCAT06
         RfQ7Hmp+VZIro9lyEFEDfsTkYxoysoLWTPmnt+BO7W4drlESQ4v4ObS3+tJl1wSrwUa9
         +3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003804; x=1769608604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Avz0zhItUvROQy3aeBayHRvtD6/6o32+NQiPJhA08ug=;
        b=mYou0+vnuhsXuUz0NOlQtvc/t7S6rkjQkMzVytq4RkUoQ0MmxI1YQhVpgCP3BulBV7
         Vq1unLtjy+o1CwTu+9KgjuWIoHxSM2I+4oTYOI9oGjwMFBIh/PPWRn1c1iT/wAeyKUwE
         z4+DSlqcVe8i7XJT7tBcBfRU2YxKW8PnhrcCu0F27RiI+qHzt4CeMPAzQnLdr0cwTMFY
         JQtsZ4ul2rWa2D7b0XdLB8OvF/UkPOg9J1yhq7U19LBZ3Da5O/SNVUWb5aKqE4tVFQKh
         h6TsrFdJnN2NdCymPrHRpuIJbAWI3eLsZj3nnDtEGZW5nEDOPtDG9kHo3DCqNzdv/cST
         zPaA==
X-Forwarded-Encrypted: i=1; AJvYcCWdYGWHAec1rf2SN5ZYWQLQ3Z7ucsqN8XrKuNzLcHvxw8NLGIHnfkehqEIOJ5wq6L7JUd0Ux4UJS67a8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwokZe+aS2iiRRHmCjZbFPXGiTxUjdI8ZywZMrJZdDF7ZzDmcPK
	fK+dmt8iJLpgDU/7Hapzs6SDttttzai0iIUvlUn3NOU5elndJbGX/H5NDRbGxJHN/qE=
X-Gm-Gg: AZuq6aKM96DvLwJrnozXJnl17nRRTplMTSVIgvlaTYH5JFqOLHJrGfinBHo067wfyX0
	o0/Xay5z5V8yfV6H4aDMxGIz3W8HHbf0YfaTg4YUtKQp+rQwqXrUTZhCFuKtoGpIJznN3gfj5LN
	1ITmCGYHgUsRMT99HpvsXkQIRq4l2KCKx3fG8+fJcCyDuSWLR7PV8bWX4X8YQrpO+HFUUGA4ehX
	NtfXatPchCj+mUVfzDu+aqV4H8yqTlUEeDfTx0dltdLN1wK7MNZpdzLzgEXGwWi2UTNgaRiC7K7
	kIhoDJJuMBtb6bMBK0J8VZ8X1MpH37jSgXhHzn9BXTpY0zw71EQv1ZwJg6htOL/XGKq1IrbtJz9
	9CnPsedbAiAUDhcWhDUBywbUMeTJ0LeYYs+wnZbkYQfzd8Ahj2sWywl0al0q+43HO/P70KocCmQ
	bGALL6ozt2y1LD4JpbbRenNEIvip0DMnl3tDI1HkggbRwISE+dey2kctLXKwXOjzqh9dM=
X-Received: by 2002:a05:620a:1013:b0:8c6:a814:726b with SMTP id af79cd13be357-8c6a814748dmr1789323485a.75.1769003804452;
        Wed, 21 Jan 2026 05:56:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6a9d97sm125563246d6.34.2026.01.21.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:56:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viYhP-00000006E7g-1MyT;
	Wed, 21 Jan 2026 09:56:43 -0400
Date: Wed, 21 Jan 2026 09:56:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Edward Srouji <edwards@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Add DMABUF object type and
 operations
Message-ID: <20260121135643.GA961572@ziepe.ca>
References: <20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com>
 <20260108-dmabuf-export-v1-1-6d47d46580d3@nvidia.com>
 <20260120181520.GS961572@ziepe.ca>
 <20260121083246.GV13201@unreal>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121083246.GV13201@unreal>

On Wed, Jan 21, 2026 at 10:32:46AM +0200, Leon Romanovsky wrote:
> > > +static int uverbs_dmabuf_attach(struct dma_buf *dmabuf,
> > > +				struct dma_buf_attachment *attachment)
> > > +{
> > > +	struct ib_uverbs_dmabuf_file *priv = dmabuf->priv;
> > > +
> > > +	if (!attachment->peer2peer)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (priv->revoked)
> > > +		return -ENODEV;
> > 
> > This should only be checked in map
> 
> I disagree with word "only", the more accurate word is "too". There is
> no need to allow new importer attach if this exporter is marked as
> revoked.

It must check during map, during attach as well is redundant and a bit
confusing.

> > This should also eventually call the new revoke testing function Leon
> > is adding
> 
> We will add it once my series will be accepted.

It should also refuse pinned importers with an always fail pin op
until we get that done. This is a case like VFIO where the lifecycle
is more general and I don't want to accidently allow things that
shouldn't work.

Jason
