Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDBC43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5D621773
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eatwithus.eu header.i=@eatwithus.eu header.b="SJH9RNQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfC2JEs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:04:48 -0400
Received: from mail.eatwithus.eu ([176.107.131.6]:33684 "EHLO eatwithus.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbfC2JEs (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 05:04:48 -0400
Received: by eatwithus.eu (Postfix, from userid 1001)
        id 6C2E488A93; Fri, 29 Mar 2019 10:03:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eatwithus.eu; s=mail;
        t=1553850284; bh=cd5EgeQdknypVv/toasjvJr+1fSRH55Ph4rD02X3yd0=;
        h=Date:From:To:Subject:From;
        b=SJH9RNQ/1m+Undq4wmmIjtrB6clQpJJj5hIqjDQeH+fJ1yDTemFuQJhu5TbxMC+RM
         qja/nvqf4hH3M2NBKDi85qH97vP+SxHXJ33dTElX0Da2G3eqiYVP9fX6QHCZSlvQuL
         rpMiSbZwl0WWAI8esvQaVE1hQypfErT5iDX8qOlk=
Received: by mail.eatwithus.eu for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 09:02:57 GMT
Message-ID: <20190329100230-0.1.q.9qd.0.t2u2bf3ma5@eatwithus.eu>
Date:   Fri, 29 Mar 2019 09:02:57 GMT
From:   "Radoslav Dobrev" <radoslav.dobrev@eatwithus.eu>
To:     <linux-media@vger.kernel.org>
Subject: =?UTF-8?Q?=D0=9C=D0=BE=D1=82=D0=B8=D0=B2=D0=B8=D1=80=D0=B0=D0=BD_=D0=BF=D0=B5=D1=80=D1=81=D0=BE=D0=BD=D0=B0=D0=BB?=
X-Mailer: mail.eatwithus.eu
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

=D0=97=D0=B4=D1=80=D0=B0=D0=B2=D0=B5=D0=B9=D1=82=D0=B5!

=D0=92=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D1=85=
=D1=80=D0=B0=D0=BD=D0=B0 =D1=81=D0=B5 =D0=BD=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=
=D0=B0=D1=82 =D1=81=D1=80=D0=B5=D0=B4 =D0=BB=D1=8E=D0=B1=D0=B8=D0=BC=D0=B8=
=D1=82=D0=B5 =D1=81=D0=BE=D1=86=D0=B8=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=
=D0=B8=D0=B4=D0=BE=D0=B1=D0=B8=D0=B2=D0=BA=D0=B8 =D0=BD=D0=B0 =D1=80=D0=B0=
=D0=B1=D0=BE=D1=82=D0=B5=D1=89=D0=B8=D1=82=D0=B5 =D1=85=D0=BE=D1=80=D0=B0=
 =D0=B8 =D1=81=D1=80=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B9-=D0=BF=D1=80=D0=B5=D0=
=B4=D0=BF=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=BD=D0=
=B0=D1=87=D0=B8=D0=BD=D0=B8 =D0=B7=D0=B0 =D1=81=D1=82=D0=B8=D0=BC=D1=83=D0=
=BB=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BE=D1=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=
=82=D0=BE=D0=B4=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=B5. =D0=A2=D0=B5 =D0=
=BF=D0=BE=D0=B4=D0=BE=D0=B1=D1=80=D1=8F=D0=B2=D0=B0=D1=82 =D0=B5=D1=84=D0=
=B5=D0=BA=D1=82=D0=B8=D0=B2=D0=BD=D0=BE=D1=81=D1=82=D1=82=D0=B0 =D0=B8 =D0=
=BF=D1=80=D0=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=
=D0=BE=D1=81=D1=82=D1=82=D0=B0 =D0=BD=D0=B0 =D0=92=D0=B0=D1=88=D0=B8=D1=82=
=D0=B5 =D1=81=D0=BB=D1=83=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D0=B8.

=D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=D1=80=D0=B5=D0=BD=D0=B8=D0=B5 =
=D0=BD=D0=B0 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D0=B7=
=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B0 =D1=80=D0=B5=D0=B0=D0=BB=D0=B8=D0=B7=
=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D1=81=D0=BF=D0=B5=D1=81=D1=82=D1=8F=D0=B2=
=D0=B0=D0=BD=D0=B8=D1=8F =E2=80=93 =D1=81=D1=82=D0=BE=D0=B9=D0=BD=D0=BE=D1=
=81=D1=82=D1=82=D0=B0 =D0=BD=D0=B0 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=
=B8=D1=82=D0=B5 =D0=BD=D0=B5 =D1=81=D0=B5 =D0=BE=D0=B1=D0=BB=D0=B0=D0=B3=D0=
=B0 =D1=81 =D0=B4=D0=B0=D0=BD=D1=8A=D1=86=D0=B8 =D0=B8 =D0=BE=D1=81=D0=B8=
=D0=B3=D1=83=D1=80=D0=BE=D0=B2=D0=BA=D0=B8 =D0=B4=D0=BE 60=D0=BB=D0=B2 =D0=
=BC=D0=B5=D1=81=D0=B5=D1=87=D0=BD=D0=BE =D0=B7=D0=B0 =D0=B2=D1=81=D0=B5=D0=
=BA=D0=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=B8=D0=BA, =D0=B0 =D0=B2=
 =D1=81=D1=8A=D1=89=D0=BE=D1=82=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D0=B5 =D0=BC=
=D0=BE=D1=82=D0=B8=D0=B2=D0=B0=D1=86=D0=B8=D1=8F=D1=82=D0=B0 =D0=B8 =D0=BF=
=D0=BE=D0=BA=D1=83=D0=BF=D0=B0=D1=82=D0=B5=D0=BB=D0=BD=D0=B0=D1=82=D0=B0 =
=D1=81=D0=BF=D0=BE=D1=81=D0=BE=D0=B1=D0=BD=D0=BE=D1=81=D1=82 =D0=BD=D0=B0=
 =D1=81=D0=BB=D1=83=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=B5 =D0=BD=
=D0=B0=D1=80=D0=B0=D1=81=D1=82=D0=B2=D0=B0.

=D0=90=D0=BA=D0=BE =D0=BF=D1=80=D0=BE=D1=8F=D0=B2=D1=8F=D0=B2=D0=B0=D1=82=
=D0=B5 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=B5=D1=81 =D0=BA=D1=8A=D0=BC =D0=B2=
=D1=8A=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE=D1=81=D1=82=D0=B8=D1=82=D0=B5 =
=D0=B7=D0=B0 =D0=B2=D1=8A=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=
=D0=B0 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=B8 =D0=B7=D0=B0 =D1=85=D1=80=
=D0=B0=D0=BD=D0=B0 =D0=B2=D1=8A=D0=B2 =D0=92=D0=B0=D1=88=D0=B0=D1=82=D0=B0=
 =D1=84=D0=B8=D1=80=D0=BC=D0=B0 =D0=B8 =D0=B6=D0=B5=D0=BB=D0=B0=D0=B5=D1=82=
=D0=B5 =D0=BF=D0=BE-=D0=BF=D0=BE=D0=B4=D1=80=D0=BE=D0=B1=D0=BD=D0=B0 =D0=B8=
=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F, =D0=B8=D0=B7=D0=BF=
=D1=80=D0=B0=D1=82=D0=B5=D1=82=D0=B5 =D0=BC=D0=B8 =D1=81=D1=8A=D0=BE=D0=B1=
=D1=89=D0=B5=D0=BD=D0=B8=D0=B5.


=D0=A0=D0=B0=D0=B4=D0=BE=D1=81=D0=BB=D0=B0=D0=B2 =D0=94=D0=BE=D0=B1=D1=80=
=D0=B5=D0=B2
Head of HR Benefit Team
www.eatwithus.eu  
