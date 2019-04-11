Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE8C10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080752083E
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="uI2VI5q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDKQMx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:12:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38577 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKQMx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 12:12:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so3803902qki.5
        for <linux-media@vger.kernel.org>; Thu, 11 Apr 2019 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=5SMFrTVgpnIlB+L9xq27Splnw33hXQG0wx1qYx9kDrA=;
        b=uI2VI5q/wEqyifypSgLu0EPIek6VDAz7bjsOB2sB7PPMLDLrQ5LdOOYhG7axETHWIr
         2l4geZbnHpsR2O07IKGqs+iQNCM1JpkffbOp4CdeAoniEflnU1CXW3Jm5nOr0zLB+3cu
         Pyv4yhpyghNbHh1aM68WiwfB6QeUVDy7NIZqU8V86zJn9D97XJoaKV9MUztrqVBnrKuq
         2xkBv6ZTgEuzI6tt1OL7Hp/b6zJmpGZJEwLjJcqy/vG9pUIXjZuN1JDbS3DRndDirNC/
         dBY/HIOnpP4YdHnm+DZk8psqdfjOjJrL0JccMdomgxNJ5tiRTXjfSpuNCAutVa/LoOJp
         JoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=5SMFrTVgpnIlB+L9xq27Splnw33hXQG0wx1qYx9kDrA=;
        b=RnT4+2FCAg0pra0ybra5flTBqLlIGs7rUPzY73FXsyiOL3+Ri1SDAZAu2DEBbC+eII
         snoDocF0J4ke1tbqQw9v3tlFGv654514ogknNs3sRxLk6gGK4WpGrexCQzDqhxSbRECU
         MPveDktcIN4XArfn09MRC69U9+LBrX8uQQBkh/LLLeaD6aoZaiJwADpK4IaURToa3zwp
         tMLdO6Q/aI5S1YTkinuZ/lB9MP2Ui7X860cg5cLxnKjx3WzUnFjkBrVytJfRioVtMG07
         bWOMqwJi6dk+cVJySm97Z8g4ysURUCJr9O9Z3y6tUgyu4z/Vj33Q/bu+ajolSQw7U6ep
         xsRg==
X-Gm-Message-State: APjAAAVNQT2vGphFAQh+KprROKZMiWQD9BRJckCEVa/3elvKJCXrzmUi
        eSbQc5bp7hk+NL8d8CZ9JyzFyQ==
X-Google-Smtp-Source: APXvYqw+kkF6PBG78Q7kn26FAP7K3sZKQ2AYsFasa0BfATD+HtkHzIpJbSUYUD6AG9dqtuhSbnE/dg==
X-Received: by 2002:a37:a296:: with SMTP id l144mr36472988qke.20.1554999172265;
        Thu, 11 Apr 2019 09:12:52 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id g189sm6601996qkd.60.2019.04.11.09.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 09:12:50 -0700 (PDT)
Message-ID: <88dc2edc5e6146d4dc0a8367b5bbe9aaa6241d0b.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/9] staging: video: rockchip: add v4l2 decoder
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Randy Li <randy.li@rock-chips.com>
Cc:     ayaka <ayaka@soulik.info>, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, maxime.ripard@bootlin.com, joro@8bytes.org,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
Date:   Thu, 11 Apr 2019 12:12:49 -0400
In-Reply-To: <cc5816d8-43cb-aedc-e496-f92baf37e6b3@rock-chips.com>
References: <20190410124226.8612-1-ayaka@soulik.info>
         <20190410124226.8612-2-ayaka@soulik.info>
         <2b225e07b03359311c21ab2b3c41096a97beb338.camel@ndufresne.ca>
         <cc5816d8-43cb-aedc-e496-f92baf37e6b3@rock-chips.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-zjlg6Ecl6t7mB6EBykWt"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--=-zjlg6Ecl6t7mB6EBykWt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 11 avril 2019 =C3=A0 09:29 +0800, Randy Li a =C3=A9crit :
> > We agreed with Maxime and Ezequiel that there will be two distinct
> > format, V4L2_PIX_FMT_H264_SLICE_RAW and V4L2_PIX_FMT_H264_SLICE_ANNEXB.
> > And user-pace will take care of providing the right information.
>=20
> I have no idea on what does the SLICE_RAW mean here.

If you skip the NAL headers, SLICE_RAW is what is left. This is exactly
what is passed in VAAPI, and what makes Rockchip HW difficult to
support through this abstraction apparently. The rationale is that all
the information that was in the rest of the bitstream is already passed
in C structures. If this isn't the case, let me know, since it would be
a bad name indeed.

Paul asked us why not always required ANNEX-B with start code as a
super set. This is not very efficient, since it means that whenever you
have a stream from an ISOMP4 media, you endup having to convert the AVC
headers into ANNEX-B start code, and you loose the optimization the AVC
header provides (AVC format is basically just a NAL type and it's size,
so you can navigate through the stream with very little reads). The
other thing is the memory alignment the require needs. I suspect that
if the HW require SLICE_RAW, you cannot just pass a random pointer
offset. So you'd need another buffer the userspace data to. Hidden
copies in drivers are quite bad, it's better to leave it to userspace
when we can in my opinion.

Now that I'm saying that out-loud, I wonder how the "one v4l2 buffer
per frame" restriction can be respected for SLICE_RAW. The receiver
would have no way to know where each slices are. Isn't there a big flaw
in this restriction ? Or did I miss-understood the format, and
SLICE_RAW is a bad name ?

>=20
> Annex B describe a byte stream format but it doesn't mean it should =20
> ship slice data with SPS or PPS

SLICE means it won't pass SPS or PPS in-band. Only slice NALs and per
slice auxiliary data if there is any. Do Rockchip needs the original
SPS/PPS bitstream ? If so, all of them ? or just the activated one ?
And when ?

>=20
> The problem of bootlin demo is it follows Annex B but withou a start=20
> code !!!!

We'll fix that if we decide to use this for testing. It was all early
and unspecified. SLICE_ANNEXB will have a start code of course, as I
don't see how you can call this ANNEXB otherwise. And I'm pretty sure
the reason Rockchip need it is to be able to split the slices (we need
to keep in mind that multiple slices per frame is commonly used in
video conference streaming). The format documentation should be really
clear about what it is, and if another HW with another format comes
that does not match, it should define and document a new format.

cheers,
Nicolas

--=-zjlg6Ecl6t7mB6EBykWt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXK9ngQAKCRBxUwItrAao
HLcFAJ4xsAhrKMIo3LOrqn1XOJOwkTWUwgCcDDyTmU6DTwrOUowmM78Ob4VxrP8=
=tBIX
-----END PGP SIGNATURE-----

--=-zjlg6Ecl6t7mB6EBykWt--

