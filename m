Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44935C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 04:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06B52075E
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 04:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bel.co.in header.i=@bel.co.in header.b="lX7O5yJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbfC1EJn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 00:09:43 -0400
Received: from mx1.bel.co.in ([103.225.12.72]:60616 "EHLO mx1.bel.co.in"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfC1EJm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 00:09:42 -0400
X-AuditID: ac143209-58fff700000056d6-50-5c9c48faff27
Received: from smtp.bel.co.in (Unknown_Domain [172.20.50.201])
        by  (Symantec Messaging Gateway) with SMTP id 77.F0.22230.AF84C9C5; Thu, 28 Mar 2019 09:39:31 +0530 (IST)
Received: (Haraka outbound); Thu, 28 Mar 2019 04:34:54 +0000
Received: from bemail.bel.co.in ([172.20.50.204])
        by smtp.bel.co.in (Haraka/2.7.0) with ESMTP id A8EE8C60-81B8-417D-A2DA-3BE1041FD937.1
        envelope-from <vinodkumart@bel.co.in>;
        Thu, 28 Mar 2019 04:34:54 +0000
Received: from 218.248.1.226
        (SquirrelMail authenticated user vinodkumart)
        by bemail.bel.co.in with HTTP;
        Thu, 28 Mar 2019 09:39:35 +0530
Message-ID: <46caa7792a2305cc62841c1ee3d10638.squirrel@bemail.bel.co.in>
Date:   Thu, 28 Mar 2019 09:39:35 +0530
Subject: TW9910 Video decoder
From:   vinodkumart@bel.co.in
To:     linux-media@vger.kernel.org
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
DKIM-Signature: v=1;a=rsa-sha256;bh=P9yxc94zB9HCDj3nS8V0VRXJIprvhvuPLr+3s7FhFW4=;c=relaxed/simple;d=bel.co.in;h=from:subject:date:message-id:to:mime-version;s=nov2015;b=lX7O5yJL80ihpSd0jFRqVVaay5LZ34UU2oXykGcLw63tuG5eTgDENmADYxgurVBBefJk2YIzR97syM6gkksaXixbiVB80/BhlX5YExqS67Tp6JDA0Q7priUatLJd8D8tqYIkJjJ112mlLLyl2oaRshUwHc+Y9q6+NsSJkfoYSUjcb4TrbCmPeR9n8sZAtwFiFgMoaZbIV9nFZPlZRN7+YhlKSENV2mZcv8qnh9MGVjr7l/CzQmNcxOgLaX6wILC8viCbc0TVMonRFTSHZeEgGyuQyfma6f5okmeGaH74T88X4fiTIkxN/PMhHc//sKD51LMP9jNeLp1JVdo3TULn+w==
X-Brightmail-Tracker: H4sIAAAAAAAAA12Uf2gTZxjH9/Yu8WLzbtdrk75mVuOBYxs0JtmyJsVqpRMqjE4cg9Fl1Gt6
        S0KTu+zuUtsyXJwTW3+MbhVmG4vCLNY6igYKw3aMxeiok8G2uqmrirNVlzJhP6uWwd5LLvWy
        /x4+3/d9nuf7vZejCGbOZKPCgsJLAhdhjcvJzyrcU9WLjUf8zuNjZu+B0+OGetD4Z2rVVtCs
        rOekQCjcwdt5ISC2hYVgHbvltVervV6Pr9rF2kOirNSxb7pq3A630+FxOnzOt2rdHtYucFG+
        ju2s1q6zdikQwycDXKy+lY+o1BEQo6y9g4vE8cE3Cgdr2XUbtiuhrzILhtgppvOfD2eWJcAe
        eh8wUYh+EX259wy5DyynGHoUoENXjwFVYOj16NTELUNemAZo+N9H2qnjAF379iKhnoJ0I+o5
        cduo1iS9Fg3/cTrHy+kqlDp3NMeN9NNoOvO3Qa0r6NVo9uCVHLfg+kHmnDHfpwxNDcySak3Q
        z6Dzk5PGfL0a7R5PEvlVrahv7FGuNtEM6rncm9uOpHeRKPN+0tgHygZ1vQZ1vQZ1vY4BYhTA
        aKfLgUPDgTnCQgrkv5jpczCzuC0NaAqwZnivJ+lnDFyH3BVNg3aqhLXAxA8YPdkqtnWFODnU
        IsUjvMxWQLL2iJ+BS7g1HmlnbfCWSsuXqMDvkCO8gp8IuwoOvY4bVS5pclyOhQNhMS63xKVI
        GiCKwG1HStW2bVxXNy+J+WFp4MGGPyJsloCIX5ugtLg8TrfH6at5wef01rCVsPLkgJ+hg5zC
        t/N8jJcK93ZQFIvgrz7cskzig3zn2+GIUpDxvfsWrNB6JWejCm5/eNjPWPWCzska2P/XoJ+x
        6eX/mymhTGkQpMzY0XwuKDnGReVwUBtdDk0vY2ou0NzYFbBBhUwB6kZWwWXzeKS1IBWPuwj2
        A+rwzTtDBDUwcHeIYEhBFHhbJdxco/pTL4XiwpJxmxXS1/GneEonqAvYVsLvj2Ju0fHHO9js
        cI9qe4VOLV5D/QVcewB+yYIAfkvl8JKauxn/IB77ZuDVTRiWajBnG8EFNaEyjelcr4TEHTzR
        oinF07I43hIcb/a9pBqvwin6eLt2JdV4NarF+1IiqcarwaJ4z+xMqvFqUvEkWwJ0P/y5dGwG
        ifOtTbPPXRjdcp5YGAquFUuePXh2Y8MX9b8zPnnnht7YlW5J6f56evKbTyYWhab+SyPkpvT4
        u1XC2QM/Xvj04yZrrbc//l02he41bL3Z2/dOdHfGMHd5ZMLx0/6Rk8PN97Mf3GXXzW2+nrh9
        44kbG6dSrziaDq3p39v2WzNLyiHO9Twhydx/99Jq/XgFAAA=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

HI,

Are you still maintaining TW9910 Video decoder. We would like to use this
IC in our project.


Best Regards
T.Vinod Kumar
Senior Engineer
Bharat Electronics Limited
Ministry of Defence, Govt. of India
Machilipatnam
Andhra Pradesh- 521001
INDIA
Contact: 0866-2527363


कागज़ के 3000 पन्नों के लिए एक पेड़ को काटा जाता है... पेड़ बचाएँ... पेड़ों का संरक्षण करें... हरियाली लाएँ... इस मेल का या इसकी किसी फाइल का प्रिंट तब तक न लें जब तक सचमुच ज़रूरत न हो !!!!
 

Every 3000 Sheets of paper costs us a tree.. Save trees... Conserve 
Trees. Don't print this email or any Files unless you really need to!!!! 

Confidentiality Notice/गोपनीय सूचना 

इस इलेक्ट्रॉनिक संदेश में शामिल जानकारी और इस संदेश के साथ दिया गया संलग्नक केवल 
प्रेषिती के अनन्य इस्तेमाल के लिए है और इसमें गोपनीय या विशेषाधिकार प्राप्त जानकारी
शामिल हो सकती है । यदि आप आशयित प्राप्तकर्ता नहीं हैं, तो कृपया तुरंत भारत इलेक्ट्रॉनिक्स के प्रेषक को बताएँ 
या support@bel.co.in पर मेल द्वारा सूचित करें और इस संदेश की सभी प्रतियाँ और उसके साथ लगे संलग्नकों को नष्ट कर दें । 
The information contained in this electronic message and any 
attachments to this message are intended for the exclusive use of
the addressee(s) and may contain confidential or privileged 
information. If you are not the intended recipient, please notify
the sender at Bharat Electronics  or support@bel.co.in immediately
and destroy all copies of this message and any attachments.


