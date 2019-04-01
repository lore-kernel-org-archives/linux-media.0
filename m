Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76146C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 15:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A6620857
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 15:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcDg6VVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDAPrj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:47:39 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41827 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDAPrj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 11:47:39 -0400
Received: by mail-ed1-f42.google.com with SMTP id a25so8664194edc.8
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3kQZkYdzjTClaMLmu3fdRubacuK2FX6mttK0xjGPOII=;
        b=pcDg6VVRkazyQVU8BbhDS1h03+4uH+vFu50ZOpN+/0kDewfLN58pAHsy+s+pWRhHn0
         YCPMdXSEb9dGxQC6ncdsKpHPiXBuo9uAPu6bRj5ny5MVjYUvWYzEBxDBzHWoKz/NlFn3
         WHankI7xcslbvLsesKM5uHVKc/X9DmBKwHWDcB8bcMgQBX+ryzdE3cUMoD9VwzMZVVVm
         aysXL97VtVeKZ+VQficqWLNC7tk13y7zgbZOjHvHVjE8oUzY15gfCQpFUpRy73+qyBgi
         tuD+AJzBUlpMXw1ZDAqs7a800ifl7KXWOg7PzxM4pvbAMjqlVfEft0GhOLMBNRuzr+6K
         vyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3kQZkYdzjTClaMLmu3fdRubacuK2FX6mttK0xjGPOII=;
        b=AFYpjO1mDHTR+hbg6w73bwinWn7d8HPt6P80OZOjR4YJJNZBpiC6C6Utk02fqt3Caw
         ilM/YFBI0I/TFjZb1v+ADKiTMdi4KmwOjPHq9bmwDuQ1ixlMOV4NywcW6o870qXzeoMk
         3O8g+PLe9045hUG6W7KQ1LxyItriVuob9hHVRATUHrMZfAMhtI6n8WQDlG7p7svTfSPe
         kHQENIoT6rMPaXQ9aidWuNQJmUfUnolZYN+N7/3p9n3ZBTqFz6C5odDLv/sX/V5fraB6
         5KUu30ogpRDBiwFc+k/KdDnW7eIRwWRRVFydLLjYxvKIxLtVwgmazuuZ8OXjJTQTfWe0
         2Maw==
X-Gm-Message-State: APjAAAU7dTg/MOAVCNoc1XVqWtJB7+CiUPlH4I0XwaPdUd6IrrVlcCBY
        Gj8mJlT+g5nKHzv/y927WygDj5i9QaS0U6hfSu9IkwYG
X-Google-Smtp-Source: APXvYqxB8YI/THOPhq7LhQvi/LJ4CijpUXw94BR0BR4pceVEc/Z/GRQLmLQ0mu0AssgmMECEzye/KL/dTSSzVvGhJM8=
X-Received: by 2002:aa7:d406:: with SMTP id z6mr42487937edq.197.1554133657395;
 Mon, 01 Apr 2019 08:47:37 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Salvador_Fern=C3=A1ndez?= <moltitronico@gmail.com>
Date:   Mon, 1 Apr 2019 17:47:26 +0200
Message-ID: <CAD4B5T8kxWOcEVZVop=u2k1G0wHFv0LSLwbe+MDQ3q-Be5hcOQ@mail.gmail.com>
Subject: [PATCH 0/0] media: uvcdriver: add support for Chicony HP Full-HD
 Camera (04f2:b62f)
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000095408e058579f0e4"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

--00000000000095408e058579f0e4
Content-Type: text/plain; charset="UTF-8"

Hi developers,

A very simple patch to add support for newer HP Full-HD Camera.
Pgp key for signature is
http://keys.gnupg.net/pks/lookup?op=get&search=0x93360317E5CECDDA

Thanks a lot for your work,


-- 
Un saludo,

Salva

--00000000000095408e058579f0e4
Content-Type: text/plain; charset="windows-1252"; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
Content-ID: <f_jtyj0x5r1>
X-Attachment-Id: f_jtyj0x5r1

owGbwMvMwME42YxZ/Om5s7cY17JoJqnlpqZkJsaXliWXZaak5sdnFMSnlebkxGekxCcn5qYWJeoV
JJYkZ8QsMqhLyUxLU9DVTc8sUUjUTynKLEstKtYHa9cvLU7SBxoBwvEQGb1khSQiFHFl5qWkVigY
GiSnpVqkmhqaGZnp6aWmWiabG5maGCcbGgKlDMxMTLh0dXWJspVLW1ubOJsdHBR0jUwNDXTMFLTB
tKGpAlCsuCSxJDNZITk/r7gEyCkqTS5RAOqPT0kty0xOjc9MUQCZkplSHB2rYKtQzaXAqaCgl+SZ
V5JalJaYnBpcmuSck1hczGmrYKiDLhlQlF+Sn5yfA5Q0gEpCnBOfmZeWzwkUDg1zjvf0c/OPDwz1
DPLWAHHBrPgg1+CQIE/nkHi3IEdf1/ggxxBXTYVaHS5tBSjQ11JwzsgEOrtSwSNAwQ0Yh7oeLgrO
4DhU0DAwSTOySjIzStNU0NJHaKpW0MsFRW98Wk5ierECHAAdEuwU7+Ia5unsGu/pEu/rGOLsAeUj
dOMCNVh1e/qFgL2mg2yAXmZKWGpeSn4RigHA4KkAuRhdKTD8UkDxgaYU5C9UpYggB0cGsqecfRyD
g+PDPF1c/XHpgcUhWI8hLlWwyIQ4AlUVUqyiBCqpsavACYxWx5xkYPj4ZiYX5Ss4hhpbGBkoaLiV
lpQWpSo45VcqBDiD/KUQnpoEzLDg6FXgRI1XcMLCHZ8KnEBAKM46GY1ZGBg5GGTFFFn+/dhtkD7x
kPfdXCZmWGHCygQqIhi4OAVgIks6OBimcz6U9Z2o2/k5e2WMwBXNzZNzKudM6jvC71PZb1+nGn6x
scNa+f8ert6vR1j22fFEFj/bl6N8r79DzkTsc+7rO/MeH7ONuFkr9vXkveVltbeEdOMnc85bderx
QZmJvIdF+mOMLcPy/X8pFN7Jrt7M4jiHqa5OLTxv8ZH+Po+kCtaVszYfrmlkVpM43zP9qAsz10YN
nh/FnG4LApc8uxSytW+aRZxH61NBPul/WmELBcJc7SStlsn8V8qpyF2sNC1wWXTURnWd0J2zD9wx
CnD5fCd4YW/gy08qJxsErl7QPeou/nOCSdnqNQwPzPcs2/rv6cwtD8PllX42dbwWuiM/5c+pt8GX
vv5MV5nQfhEA
--00000000000095408e058579f0e4
Content-Type: text/x-patch; charset="US-ASCII"; name="media_uvcvideo_hp_full_hd_camera.patch"
Content-Disposition: attachment; 
	filename="media_uvcvideo_hp_full_hd_camera.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtyj0roh0>
X-Attachment-Id: f_jtyj0roh0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfZHJpdmVyLmMgYi9kcml2ZXJz
L21lZGlhL3VzYi91dmMvdXZjX2RyaXZlci5jCmluZGV4IDEwY2ZlOGU1MTYyNi4uZWU5YzcyNTQz
YzExIDEwMDY0NAotLS0gYS9kcml2ZXJzL21lZGlhL3VzYi91dmMvdXZjX2RyaXZlci5jCisrKyBi
L2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfZHJpdmVyLmMKQEAgLTI1MTAsNiArMjUxMCwxNSBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgdXZjX2lkc1tdID0gewogCSAgLmJJ
bnRlcmZhY2VTdWJDbGFzcwk9IDEsCiAJICAuYkludGVyZmFjZVByb3RvY29sCT0gMCwKIAkgIC5k
cml2ZXJfaW5mbwkJPSBVVkNfSU5GT19RVUlSSyhVVkNfUVVJUktfUkVTVFJJQ1RfRlJBTUVfUkFU
RSkgfSwKKyAgICAgICAgLyogQ2hpY29ueSBIUCBGdWxsLUhEIENhbWVyYSAoMDRmMjpiNjJmKSAq
LworICAgICAgICB7IC5tYXRjaF9mbGFncyAgICAgICAgICA9IFVTQl9ERVZJQ0VfSURfTUFUQ0hf
REVWSUNFCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVVNCX0RFVklDRV9JRF9N
QVRDSF9JTlRfSU5GTywKKyAgICAgICAgICAuaWRWZW5kb3IgICAgICAgICAgICAgPSAweDA0ZjIs
CisgICAgICAgICAgLmlkUHJvZHVjdCAgICAgICAgICAgID0gMHhiNjJmLAorICAgICAgICAgIC5i
SW50ZXJmYWNlQ2xhc3MgICAgICA9IFVTQl9DTEFTU19WSURFTywKKyAgICAgICAgICAuYkludGVy
ZmFjZVN1YkNsYXNzICAgPSAxLAorICAgICAgICAgIC5iSW50ZXJmYWNlUHJvdG9jb2wgICA9IDAs
CisgICAgICAgICAgLmRyaXZlcl9pbmZvICAgICAgICAgID0gVVZDX0lORk9fUVVJUksoVVZDX1FV
SVJLX1JFU1RSSUNUX0ZSQU1FX1JBVEUpIH0sCiAJLyogQWxjb3IgTWljcm8gQVUzODIwIChGdXR1
cmUgQm95IFBDIFVTQiBXZWJjYW0pICovCiAJeyAubWF0Y2hfZmxhZ3MJCT0gVVNCX0RFVklDRV9J
RF9NQVRDSF9ERVZJQ0UKIAkJCQl8IFVTQl9ERVZJQ0VfSURfTUFUQ0hfSU5UX0lORk8sCg==
--00000000000095408e058579f0e4--
