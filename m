Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88A18B14
	for <linux-media@vger.kernel.org>; Mon, 10 Jun 2024 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999711; cv=none; b=Ui933I4cPAolxQNswZUqbREThaSidaXZu+TiHSNoh64DMCrmnHdS021kqpCX8l7aKTCtTwyENNyyRJcfl59zIBefh3EQSxYbAb9HZd7GtQcXJmMfaJg9xY1yw5NenkOOaQDiHvRqt7MIrtBg/o/KGG7XuujU9rn6/ig1WBeaJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999711; c=relaxed/simple;
	bh=8xIrsA1T+5toBxOwijzjFLN2cUPzrGeRDebfCiXHPaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpMnDdj5g1AQNNDlTnpolZBS8KDBMBgybNVHgcdzsgEskYIk0RmXq+dWQ6+R5OWRQKfuUOgcJHr1FSIMI+HWwFKqA3HL98bgTt22dx+sA6CWHhcYgOfcWBRqHWA6dMqg1PVScwZPH7NS+LG6mLR6twwYM9QWQT61z8vwDYUYb88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Gm815bY/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Gm815bY/"
Received: from [192.168.88.20] (91-158-144-210.elisa-laajakaista.fi [91.158.144.210])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 151C6397;
	Mon, 10 Jun 2024 08:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717999694;
	bh=8xIrsA1T+5toBxOwijzjFLN2cUPzrGeRDebfCiXHPaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gm815bY/kGCtCVY2pusXk46V6ryrT0+NJIfXxgW3rM2IVEE9WrdRYLXOI68oX2GTF
	 EEfFmAKtuPYzNfBUqX16UMgLZenwfABa67R4C4VrqXDJYqTLnixZUfoBZCaG5K0WyO
	 GsSPtz01cLuxjkO7Nm52EAlhqk8jOtBW9yiNnNuc=
Message-ID: <252fc9a1-8830-4820-b7be-5ca46d9a7ca0@ideasonboard.com>
Date: Mon, 10 Jun 2024 09:08:22 +0300
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4l-utils] [PATCH v1 1/3] libv4l2subdev: Extend API with 'which'
 argument where missing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@iki.fi>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20240610012238.30462-1-laurent.pinchart@ideasonboard.com>
 <20240610012238.30462-2-laurent.pinchart@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 xsFNBE6ms0cBEACyizowecZqXfMZtnBniOieTuFdErHAUyxVgtmr0f5ZfIi9Z4l+uUN4Zdw2
 wCEZjx3o0Z34diXBaMRJ3rAk9yB90UJAnLtb8A97Oq64DskLF81GCYB2P1i0qrG7UjpASgCA
 Ru0lVvxsWyIwSfoYoLrazbT1wkWRs8YBkkXQFfL7Mn3ZMoGPcpfwYH9O7bV1NslbmyJzRCMO
 eYV258gjCcwYlrkyIratlHCek4GrwV8Z9NQcjD5iLzrONjfafrWPwj6yn2RlL0mQEwt1lOvn
 LnI7QRtB3zxA3yB+FLsT1hx0va6xCHpX3QO2gBsyHCyVafFMrg3c/7IIWkDLngJxFgz6DLiA
 G4ld1QK/jsYqfP2GIMH1mFdjY+iagG4DqOsjip479HCWAptpNxSOCL6z3qxCU8MCz8iNOtZk
 DYXQWVscM5qgYSn+fmMM2qN+eoWlnCGVURZZLDjg387S2E1jT/dNTOsM/IqQj+ZROUZuRcF7
 0RTtuU5q1HnbRNwy+23xeoSGuwmLQ2UsUk7Q5CnrjYfiPo3wHze8avK95JBoSd+WIRmV3uoO
 rXCoYOIRlDhg9XJTrbnQ3Ot5zOa0Y9c4IpyAlut6mDtxtKXr4+8OzjSVFww7tIwadTK3wDQv
 Bus4jxHjS6dz1g2ypT65qnHen6mUUH63lhzewqO9peAHJ0SLrQARAQABzTBUb21pIFZhbGtl
 aW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT7CwY4EEwEIADgWIQTEOAw+
 ll79gQef86f6PaqMvJYe9QUCX/HruAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD6
 PaqMvJYe9WmFD/99NGoD5lBJhlFDHMZvO+Op8vCwnIRZdTsyrtGl72rVh9xRfcSgYPZUvBuT
 VDxE53mY9HaZyu1eGMccYRBaTLJSfCXl/g317CrMNdY0k40b9YeIX10feiRYEWoDIPQ3tMmA
 0nHDygzcnuPiPT68JYZ6tUOvAt7r6OX/litM+m2/E9mtp8xCoWOo/kYO4mOAIoMNvLB8vufi
 uBB4e/AvAjtny4ScuNV5c5q8MkfNIiOyag9QCiQ/JfoAqzXRjVb4VZG72AKaElwipiKCWEcU
 R4+Bu5Qbaxj7Cd36M/bI54OrbWWETJkVVSV1i0tghCd6HHyquTdFl7wYcz6cL1hn/6byVnD+
 sR3BLvSBHYp8WSwv0TCuf6tLiNgHAO1hWiQ1pOoXyMEsxZlgPXT+wb4dbNVunckwqFjGxRbl
 Rz7apFT/ZRwbazEzEzNyrBOfB55xdipG/2+SmFn0oMFqFOBEszXLQVslh64lI0CMJm2OYYe3
 PxHqYaztyeXsx13Bfnq9+bUynAQ4uW1P5DJ3OIRZWKmbQd/Me3Fq6TU57LsvwRgE0Le9PFQs
 dcP2071rMTpqTUteEgODJS4VDf4lXJfY91u32BJkiqM7/62Cqatcz5UWWHq5xeF03MIUTqdE
 qHWk3RJEoWHWQRzQfcx6Fn2fDAUKhAddvoopfcjAHfpAWJ+ENc7BTQROprNHARAAx0aat8GU
 hsusCLc4MIxOQwidecCTRc9Dz/7U2goUwhw2O5j9TPqLtp57VITmHILnvZf6q3QAho2QMQyE
 DDvHubrdtEoqaaSKxKkFie1uhWNNvXPhwkKLYieyL9m2JdU+b88HaDnpzdyTTR4uH7wk0bBa
 KbTSgIFDDe5lXInypewPO30TmYNkFSexnnM3n1PBCqiJXsJahE4ZQ+WnV5FbPUj8T2zXS2xk
 0LZ0+DwKmZ0ZDovvdEWRWrz3UzJ8DLHb7blPpGhmqj3ANXQXC7mb9qJ6J/VSl61GbxIO2Dwb
 xPNkHk8fwnxlUBCOyBti/uD2uSTgKHNdabhVm2dgFNVuS1y3bBHbI/qjC3J7rWE0WiaHWEqy
 UVPk8rsph4rqITsj2RiY70vEW0SKePrChvET7D8P1UPqmveBNNtSS7In+DdZ5kUqLV7rJnM9
 /4cwy+uZUt8cuCZlcA5u8IsBCNJudxEqBG10GHg1B6h1RZIz9Q9XfiBdaqa5+CjyFs8ua01c
 9HmyfkuhXG2OLjfQuK+Ygd56mV3lq0aFdwbaX16DG22c6flkkBSjyWXYepFtHz9KsBS0DaZb
 4IkLmZwEXpZcIOQjQ71fqlpiXkXSIaQ6YMEs8WjBbpP81h7QxWIfWtp+VnwNGc6nq5IQDESH
 mvQcsFS7d3eGVI6eyjCFdcAO8eMAEQEAAcLBXwQYAQIACQUCTqazRwIbDAAKCRD6PaqMvJYe
 9fA7EACS6exUedsBKmt4pT7nqXBcRsqm6YzT6DeCM8PWMTeaVGHiR4TnNFiT3otD5UpYQI7S
 suYxoTdHrrrBzdlKe5rUWpzoZkVK6p0s9OIvGzLT0lrb0HC9iNDWT3JgpYDnk4Z2mFi6tTbq
 xKMtpVFRA6FjviGDRsfkfoURZI51nf2RSAk/A8BEDDZ7lgJHskYoklSpwyrXhkp9FHGMaYII
 m9EKuUTX9JPDG2FTthCBrdsgWYPdJQvM+zscq09vFMQ9Fykbx5N8z/oFEUy3ACyPqW2oyfvU
 CH5WDpWBG0s5BALp1gBJPytIAd/pY/5ZdNoi0Cx3+Z7jaBFEyYJdWy1hGddpkgnMjyOfLI7B
 CFrdecTZbR5upjNSDvQ7RG85SnpYJTIin+SAUazAeA2nS6gTZzumgtdw8XmVXZwdBfF+ICof
 92UkbYcYNbzWO/GHgsNT1WnM4sa9lwCSWH8Fw1o/3bX1VVPEsnESOfxkNdu+gAF5S6+I6n3a
 ueeIlwJl5CpT5l8RpoZXEOVtXYn8zzOJ7oGZYINRV9Pf8qKGLf3Dft7zKBP832I3PQjeok7F
 yjt+9S+KgSFSHP3Pa4E7lsSdWhSlHYNdG/czhoUkSCN09C0rEK93wxACx3vtxPLjXu6RptBw
 3dRq7n+mQChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
In-Reply-To: <20240610012238.30462-2-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/06/2024 04:22, Laurent Pinchart wrote:
> Many functions exposed by libv4l2subdev have been added over time
> hardcoding usage of the V4L2_SUBDEV_FORMAT_ACTIVE state. Extend them
> with a 'which' argument to allow callers to access the TRY state as
> well. Update existing callers to pass V4L2_SUBDEV_FORMAT_ACTIVE
> unconditionally, preserving the existing behaviour.
> 
> To support accessing the TRY state when getting or setting frame
> intervals, set the V4L2_SUBDEV_CLIENT_CAP_INTERVAL_USES_WHICH client
> capability.

I would have split this one to a separate patch, but not a biggie.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>   utils/media-ctl/libv4l2subdev.c | 65 +++++++++++++++++++++------------
>   utils/media-ctl/media-ctl.c     | 11 ++++--
>   utils/media-ctl/v4l2subdev.h    | 49 ++++++++++++++++++++++---
>   3 files changed, 92 insertions(+), 33 deletions(-)
> 
> diff --git a/utils/media-ctl/libv4l2subdev.c b/utils/media-ctl/libv4l2subdev.c
> index e0df686e01c7..163fd610dce7 100644
> --- a/utils/media-ctl/libv4l2subdev.c
> +++ b/utils/media-ctl/libv4l2subdev.c
> @@ -69,7 +69,8 @@ int v4l2_subdev_open(struct media_entity *entity)
>   	ret = ioctl(entity->fd, VIDIOC_SUBDEV_QUERYCAP, &subdevcap);
>   	subdev_streams = !ret && (subdevcap.capabilities & V4L2_SUBDEV_CAP_STREAMS);
>   
> -	clientcap.capabilities = V4L2_SUBDEV_CLIENT_CAP_STREAMS;
> +	clientcap.capabilities = V4L2_SUBDEV_CLIENT_CAP_STREAMS
> +			       | V4L2_SUBDEV_CLIENT_CAP_INTERVAL_USES_WHICH;
>   
>   	ret = ioctl(entity->fd, VIDIOC_SUBDEV_S_CLIENT_CAP, &clientcap);
>   	client_streams = !ret && (clientcap.capabilities & V4L2_SUBDEV_CLIENT_CAP_STREAMS);
> @@ -240,10 +241,11 @@ int v4l2_subdev_set_selection(struct media_entity *entity,
>   
>   int v4l2_subdev_get_routing(struct media_entity *entity,
>   			    struct v4l2_subdev_route **routes,
> -			    unsigned int *num_routes)
> +			    unsigned int *num_routes,
> +			    enum v4l2_subdev_format_whence which)
>   {
>   	struct v4l2_subdev_routing routing = {
> -		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
> +		.which = which,
>   	};
>   	struct v4l2_subdev_route *r;
>   	int ret;
> @@ -287,10 +289,11 @@ int v4l2_subdev_get_routing(struct media_entity *entity,
>   
>   int v4l2_subdev_set_routing(struct media_entity *entity,
>   			    struct v4l2_subdev_route *routes,
> -			    unsigned int num_routes)
> +			    unsigned int num_routes,
> +			    enum v4l2_subdev_format_whence which)
>   {
>   	struct v4l2_subdev_routing routing = {
> -		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
> +		.which = which,
>   		.routes = (uintptr_t)routes,
>   		.num_routes = num_routes,
>   		.len_routes = num_routes,
> @@ -387,7 +390,8 @@ int v4l2_subdev_set_dv_timings(struct media_entity *entity,
>   
>   int v4l2_subdev_get_frame_interval(struct media_entity *entity,
>   				   struct v4l2_fract *interval,
> -				   unsigned int pad, unsigned int stream)
> +				   unsigned int pad, unsigned int stream,
> +				   enum v4l2_subdev_format_whence which)
>   {
>   	struct v4l2_subdev_frame_interval ival;
>   	int ret;
> @@ -404,6 +408,7 @@ int v4l2_subdev_get_frame_interval(struct media_entity *entity,
>   	memset(&ival, 0, sizeof(ival));
>   	ival.pad = pad;
>   	ival.stream = stream;
> +	ival.which = which;
>   
>   	ret = ioctl(entity->fd, VIDIOC_SUBDEV_G_FRAME_INTERVAL, &ival);
>   	if (ret < 0)
> @@ -415,7 +420,8 @@ int v4l2_subdev_get_frame_interval(struct media_entity *entity,
>   
>   int v4l2_subdev_set_frame_interval(struct media_entity *entity,
>   				   struct v4l2_fract *interval,
> -				   unsigned int pad, unsigned int stream)
> +				   unsigned int pad, unsigned int stream,
> +				   enum v4l2_subdev_format_whence which)
>   {
>   	struct v4l2_subdev_frame_interval ival;
>   	int ret;
> @@ -433,6 +439,7 @@ int v4l2_subdev_set_frame_interval(struct media_entity *entity,
>   	ival.pad = pad;
>   	ival.stream = stream;
>   	ival.interval = *interval;
> +	ival.which = which;
>   
>   	ret = ioctl(entity->fd, VIDIOC_SUBDEV_S_FRAME_INTERVAL, &ival);
>   	if (ret < 0)
> @@ -514,7 +521,9 @@ static int v4l2_subdev_parse_setup_route(struct media_device *media,
>   	return 0;
>   }
>   
> -int v4l2_subdev_parse_setup_routes(struct media_device *media, const char *p)
> +int v4l2_subdev_parse_setup_routes(struct media_device *media,
> +				   enum v4l2_subdev_format_whence which,
> +				   const char *p)
>   {
>   	struct media_entity *entity;
>   	struct v4l2_subdev_route *routes;
> @@ -578,7 +587,7 @@ int v4l2_subdev_parse_setup_routes(struct media_device *media, const char *p)
>   			  r->flags);
>   	}
>   
> -	ret = v4l2_subdev_set_routing(entity, routes, num_routes);
> +	ret = v4l2_subdev_set_routing(entity, routes, num_routes, which);
>   	if (ret) {
>   		media_dbg(entity->media, "VIDIOC_SUBDEV_S_ROUTING failed: %d\n",
>   			  ret);
> @@ -961,7 +970,8 @@ static struct media_pad *v4l2_subdev_parse_pad_format(
>   
>   static int set_format(struct media_pad *pad,
>   		      unsigned int stream,
> -		      struct v4l2_mbus_framefmt *format)
> +		      struct v4l2_mbus_framefmt *format,
> +		      enum v4l2_subdev_format_whence which)
>   {
>   	int ret;
>   
> @@ -975,7 +985,7 @@ static int set_format(struct media_pad *pad,
>   		  pad->entity->info.name, pad->index, stream);
>   
>   	ret = v4l2_subdev_set_format(pad->entity, format, pad->index, stream,
> -				     V4L2_SUBDEV_FORMAT_ACTIVE);
> +				     which);
>   	if (ret < 0) {
>   		media_dbg(pad->entity->media,
>   			  "Unable to set format: %s (%d)\n",
> @@ -992,7 +1002,8 @@ static int set_format(struct media_pad *pad,
>   }
>   
>   static int set_selection(struct media_pad *pad, unsigned int stream,
> -			 unsigned int target, struct v4l2_rect *rect)
> +			 unsigned int target, struct v4l2_rect *rect,
> +			 enum v4l2_subdev_format_whence which)
>   {
>   	int ret;
>   
> @@ -1005,7 +1016,7 @@ static int set_selection(struct media_pad *pad, unsigned int stream,
>   		  pad->entity->info.name, pad->index, stream);
>   
>   	ret = v4l2_subdev_set_selection(pad->entity, rect, pad->index, stream,
> -					target, V4L2_SUBDEV_FORMAT_ACTIVE);
> +					target, which);
>   	if (ret < 0) {
>   		media_dbg(pad->entity->media,
>   			  "Unable to set selection rectangle: %s (%d)\n",
> @@ -1021,7 +1032,8 @@ static int set_selection(struct media_pad *pad, unsigned int stream,
>   }
>   
>   static int set_frame_interval(struct media_pad *pad, unsigned int stream,
> -			      struct v4l2_fract *interval)
> +			      struct v4l2_fract *interval,
> +			      enum v4l2_subdev_format_whence which)
>   {
>   	int ret;
>   
> @@ -1034,7 +1046,7 @@ static int set_frame_interval(struct media_pad *pad, unsigned int stream,
>   		  pad->entity->info.name, pad->index, stream);
>   
>   	ret = v4l2_subdev_set_frame_interval(pad->entity, interval, pad->index,
> -					     stream);
> +					     stream, which);
>   	if (ret < 0) {
>   		media_dbg(pad->entity->media,
>   			  "Unable to set frame interval: %s (%d)",
> @@ -1050,6 +1062,7 @@ static int set_frame_interval(struct media_pad *pad, unsigned int stream,
>   
>   
>   static int v4l2_subdev_parse_setup_format(struct media_device *media,
> +					  enum v4l2_subdev_format_whence which,
>   					  const char *p, char **endp)
>   {
>   	struct v4l2_mbus_framefmt format = { 0, 0, 0 };
> @@ -1072,26 +1085,26 @@ static int v4l2_subdev_parse_setup_format(struct media_device *media,
>   	}
>   
>   	if (pad->flags & MEDIA_PAD_FL_SINK) {
> -		ret = set_format(pad, stream, &format);
> +		ret = set_format(pad, stream, &format, which);
>   		if (ret < 0)
>   			return ret;
>   	}
>   
> -	ret = set_selection(pad, stream, V4L2_SEL_TGT_CROP, &crop);
> +	ret = set_selection(pad, stream, V4L2_SEL_TGT_CROP, &crop, which);
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = set_selection(pad, stream, V4L2_SEL_TGT_COMPOSE, &compose);
> +	ret = set_selection(pad, stream, V4L2_SEL_TGT_COMPOSE, &compose, which);
>   	if (ret < 0)
>   		return ret;
>   
>   	if (pad->flags & MEDIA_PAD_FL_SOURCE) {
> -		ret = set_format(pad, stream, &format);
> +		ret = set_format(pad, stream, &format, which);
>   		if (ret < 0)
>   			return ret;
>   	}
>   
> -	ret = set_frame_interval(pad, stream, &interval);
> +	ret = set_frame_interval(pad, stream, &interval, which);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -1109,9 +1122,11 @@ static int v4l2_subdev_parse_setup_format(struct media_device *media,
>   			if (link->source == pad &&
>   			    link->sink->entity->info.type == MEDIA_ENT_T_V4L2_SUBDEV) {
>   				remote_format = format;
> -				set_format(link->sink, stream, &remote_format);
> +				set_format(link->sink, stream, &remote_format,
> +					   which);
>   
> -				ret = set_frame_interval(link->sink, stream, &interval);
> +				ret = set_frame_interval(link->sink, stream,
> +							 &interval, which);
>   				if (ret < 0 && ret != -EINVAL && ret != -ENOTTY)
>   					return ret;
>   			}
> @@ -1122,13 +1137,15 @@ static int v4l2_subdev_parse_setup_format(struct media_device *media,
>   	return 0;
>   }
>   
> -int v4l2_subdev_parse_setup_formats(struct media_device *media, const char *p)
> +int v4l2_subdev_parse_setup_formats(struct media_device *media,
> +				    enum v4l2_subdev_format_whence which,
> +				    const char *p)
>   {
>   	char *end;
>   	int ret;
>   
>   	do {
> -		ret = v4l2_subdev_parse_setup_format(media, p, &end);
> +		ret = v4l2_subdev_parse_setup_format(media, which, p, &end);
>   		if (ret < 0)
>   			return ret;
>   
> diff --git a/utils/media-ctl/media-ctl.c b/utils/media-ctl/media-ctl.c
> index 1a9e393ac1f3..44256df953db 100644
> --- a/utils/media-ctl/media-ctl.c
> +++ b/utils/media-ctl/media-ctl.c
> @@ -108,7 +108,8 @@ static void v4l2_subdev_print_format(struct media_entity *entity,
>   	if (ret != 0)
>   		return;
>   
> -	ret = v4l2_subdev_get_frame_interval(entity, &interval, pad, stream);
> +	ret = v4l2_subdev_get_frame_interval(entity, &interval, pad, stream,
> +					     V4L2_SUBDEV_FORMAT_ACTIVE);
>   	if (ret != 0 && ret != -ENOTTY && ret != -EINVAL)
>   		return;
>   
> @@ -527,7 +528,8 @@ static void media_print_topology_text_entity(struct media_device *media,
>   	unsigned int padding;
>   
>   	if (media_entity_type(entity) == MEDIA_ENT_T_V4L2_SUBDEV)
> -		v4l2_subdev_get_routing(entity, &routes, &num_routes);
> +		v4l2_subdev_get_routing(entity, &routes, &num_routes,
> +					V4L2_SUBDEV_FORMAT_ACTIVE);
>   
>   	padding = printf("- entity %u: ", info->id);
>   	printf("%s (%u pad%s, %u link%s", info->name,
> @@ -738,7 +740,9 @@ int main(int argc, char **argv)
>   	}
>   
>   	if (media_opts.routes) {
> -		ret = v4l2_subdev_parse_setup_routes(media, media_opts.routes);
> +		ret = v4l2_subdev_parse_setup_routes(media,
> +						     V4L2_SUBDEV_FORMAT_ACTIVE,
> +						     media_opts.routes);
>   		if (ret) {
>   			printf("Unable to setup routes: %s (%d)\n",
>   			       strerror(-ret), -ret);
> @@ -748,6 +752,7 @@ int main(int argc, char **argv)
>   
>   	if (media_opts.formats) {
>   		ret = v4l2_subdev_parse_setup_formats(media,
> +						      V4L2_SUBDEV_FORMAT_ACTIVE,
>   						      media_opts.formats);
>   		if (ret) {
>   			printf("Unable to setup formats: %s (%d)\n",
> diff --git a/utils/media-ctl/v4l2subdev.h b/utils/media-ctl/v4l2subdev.h
> index 1277040bfeae..0c1feae28e88 100644
> --- a/utils/media-ctl/v4l2subdev.h
> +++ b/utils/media-ctl/v4l2subdev.h
> @@ -142,32 +142,44 @@ int v4l2_subdev_set_selection(struct media_entity *entity,
>    * @param entity - subdev-device media entity.
>    * @param routes - routes of the subdev.
>    * @param num_routes - number of routes.
> + * @param which - identifier of the routes to get.
>    *
>    * Get the routes of @a entity and return them in an allocated array in @a routes
>    * and the number of routes in @a num_routes.
>    *
>    * The caller is responsible for freeing the routes array after use.
>    *
> + * @a which is set to V4L2_SUBDEV_FORMAT_TRY to get the routing table stored in
> + * the file handle, of V4L2_SUBDEV_FORMAT_ACTIVE to get the device's active
> + * routing table.
> + *
>    * @return 0 on success, or a negative error code on failure.
>    */
>   int v4l2_subdev_get_routing(struct media_entity *entity,
>   			    struct v4l2_subdev_route **routes,
> -			    unsigned int *num_routes);
> +			    unsigned int *num_routes,
> +			    enum v4l2_subdev_format_whence which);
>   
>   /**
>    * @brief Set the routing table of a subdev media entity.
>    * @param entity - subdev-device media entity.
>    * @param routes - routes of the subdev.
>    * @param num_routes - number of routes.
> + * @param which - identifier of the routes to set.
>    *
>    * Set the routes of @a entity. The routes are given in @a routes with the
>    * length of @a num_routes.
>    *
> + * @a which is set to V4L2_SUBDEV_FORMAT_TRY to set the routing table stored in
> + * the file handle, of V4L2_SUBDEV_FORMAT_ACTIVE to set the device's active
> + * routing table.
> + *
>    * @return 0 on success, or a negative error code on failure.
>    */
>   int v4l2_subdev_set_routing(struct media_entity *entity,
>   			    struct v4l2_subdev_route *route,
> -			    unsigned int num_routes);
> +			    unsigned int num_routes,
> +			    enum v4l2_subdev_format_whence which);
>   
>   /**
>    * @brief Query the digital video capabilities of a pad.
> @@ -228,6 +240,7 @@ int v4l2_subdev_set_dv_timings(struct media_entity *entity,
>    * @param interval - frame interval to be filled.
>    * @param pad - pad number.
>    * @param stream - stream number.
> + * @param which - identifier of the interval to get.
>    *
>    * Retrieve the current frame interval on subdev @a entity and store it in the
>    * @a interval structure.
> @@ -235,11 +248,16 @@ int v4l2_subdev_set_dv_timings(struct media_entity *entity,
>    * Frame interval retrieving is usually supported only on devices at the
>    * beginning of video pipelines, such as sensors.
>    *
> + * @a which is set to V4L2_SUBDEV_FORMAT_TRY to get the frame interval stored
> + * in the file handle, of V4L2_SUBDEV_FORMAT_ACTIVE to get the device's active
> + * frame interval.
> + *
>    * @return 0 on success, or a negative error code on failure.
>    */
>   
>   int v4l2_subdev_get_frame_interval(struct media_entity *entity,
> -	struct v4l2_fract *interval, unsigned int pad, unsigned int stream);
> +	struct v4l2_fract *interval, unsigned int pad, unsigned int stream,
> +	enum v4l2_subdev_format_whence which);
>   
>   /**
>    * @brief Set the frame interval on a sub-device.
> @@ -247,6 +265,7 @@ int v4l2_subdev_get_frame_interval(struct media_entity *entity,
>    * @param interval - frame interval.
>    * @param pad - pad number.
>    * @param stream - stream number.
> + * @param which - identifier of the interval to set.
>    *
>    * Set the frame interval on subdev @a entity to @a interval. The driver is
>    * allowed to modify the requested frame interval, in which case @a interval is
> @@ -255,14 +274,20 @@ int v4l2_subdev_get_frame_interval(struct media_entity *entity,
>    * Frame interval setting is usually supported only on devices at the beginning
>    * of video pipelines, such as sensors.
>    *
> + * @a which is set to V4L2_SUBDEV_FORMAT_TRY to set the frame interval stored
> + * in the file handle, of V4L2_SUBDEV_FORMAT_ACTIVE to set the device's active
> + * frame interval.
> + *
>    * @return 0 on success, or a negative error code on failure.
>    */
>   int v4l2_subdev_set_frame_interval(struct media_entity *entity,
> -	struct v4l2_fract *interval, unsigned int pad, unsigned int stream);
> +	struct v4l2_fract *interval, unsigned int pad, unsigned int stream,
> +	enum v4l2_subdev_format_whence which);
>   
>   /**
>    * @brief Parse a string and apply format, crop and frame interval settings.
>    * @param media - media device.
> + * @param which - identifier of the parameters to set.
>    * @param p - input string
>    * @param endp - pointer to string p where parsing ended (return)
>    *
> @@ -272,20 +297,32 @@ int v4l2_subdev_set_frame_interval(struct media_entity *entity,
>    *
>    * Format strings are separeted by commas (,).
>    *
> + * @a which is set to V4L2_SUBDEV_FORMAT_TRY to set the parameters stored in the
> + * file handle, of V4L2_SUBDEV_FORMAT_ACTIVE to set the device's active
> + * parameters.
> + *
>    * @return 0 on success, or a negative error code on failure.
>    */
> -int v4l2_subdev_parse_setup_formats(struct media_device *media, const char *p);
> +int v4l2_subdev_parse_setup_formats(struct media_device *media,
> +				    enum v4l2_subdev_format_whence which,
> +				    const char *p);
>   
>   /**
>    * @brief Parse a string and apply route settings.
>    * @param media - media device.
> + * @param which - identifier of the routes to set.
>    * @param p - input string
>    *
>    * Parse string @a p and apply route settings to a subdev.
>    *
> + * @a which is set to V4L2_SUBDEV_FORMAT_TRY to set the routes stored in the
> + * file handle, of V4L2_SUBDEV_FORMAT_ACTIVE to set the device's active routes.
> + *
>    * @return 0 on success, or a negative error code on failure.
>    */
> -int v4l2_subdev_parse_setup_routes(struct media_device *media, const char *p);
> +int v4l2_subdev_parse_setup_routes(struct media_device *media,
> +				   enum v4l2_subdev_format_whence which,
> +				   const char *p);
>   
>   /**
>    * @brief Convert media bus pixel code to string.

