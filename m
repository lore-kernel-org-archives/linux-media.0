Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2A3370EB
	for <linux-media@vger.kernel.org>; Mon,  9 Feb 2026 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670204; cv=none; b=Gfxrg0y4UhHKR+vQo2QEvNtAPiql8yFEdRfMCQUWLqQo1+LP1SlaaRGYVyabhO3fujgDxD4I9dWrPpOY8YPN/A/le09qtbOulLpeRoHDZhCLqyP4s96BzPZYenrZK1G05gcHZOP52kQvqWg7JncmvYmkTppbjMZAEBrh5DXmp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670204; c=relaxed/simple;
	bh=nYakJEkqnodvpY7ze+n1lf/N1ISCqnfJ3zQ6Q5A/J3Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cCyfhiMjTr9MeyuVg9YrbUboVZjU0CS6HadcOTjsYmYaep6hms8EzbIBUF0lvDdMHa5Xr9hMPcqrj+fi25ZJItXmX4HsTxaOIvE8xcNcYnjbcEXUcF+yCmMeCO6Di2GuUhM5FB52AaAbinXY5V3qWQCG0vz88mbfQ0NJc8ZOsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-663019e3e05so6998978eaf.3
        for <linux-media@vger.kernel.org>; Mon, 09 Feb 2026 12:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670202; x=1771275002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ZXkYD37uRxTxUdPapHpEoQXRtO5EYvbOzRwBsHBhs=;
        b=czM4rQataz5hjD8ScIEcOB3VvYUI59PC2+0m1BjGxHeWwSxDMFbbSgdgKU8FqC2w4R
         eXl4RnO4p8Vz3YJtbmQRgDEFyuC0eR3JR8V5pL2s1a7uVdI4NN59z/yQihc0dezFB3Ds
         GzsHywBVZqj8KwgXAboloNF81lYdg2F4MnnjK5uoXnh0u8mRM2ERla032TKh7d2gcixD
         bn8xZXLSWq0800R/ynzl6/J+QEjan73BgOz3iaCBaAS79mta3aFgaHRAsI6275TRAVHI
         ROzFR+8GK1pyfoypCvyd9CirlEO0d0TmQhHdFC8W2YOaSIPcsGjE5dl8mv7yOFkBsK/B
         +H0g==
X-Forwarded-Encrypted: i=1; AJvYcCXKpyoCUuQ6Ou4Ug4lBgtDsL6kTD1o5Ng7mbNfguPSoRJs4kE2QgLKxyA0LW65KUkh6tXF4Nmti+5eZoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVknCLYQLNwQ2UNoIOXRNMHBTSGYB+CdKYB/tHINSfOURQfApX
	0N9n8q8S51+2faMxFdI5bdD/K70fiPYqTVELVibbbMtoErjAJfvDPlPEsN3+XG0YdUK9jmHF3kW
	b8oeBOhtYe1RmS7NjLv2YtSQvm+VsCsO9jEGPkWUKj0C6b84LwueoD7xYNo8=
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4ded:b0:672:afe2:4b7e with SMTP id
 006d021491bc7-672aff19c38mr335833eaf.19.1770670202305; Mon, 09 Feb 2026
 12:50:02 -0800 (PST)
Date: Mon, 09 Feb 2026 12:50:02 -0800
In-Reply-To: <23112bc4-a498-4089-a225-1440c2151ce2@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698a487a.050a0220.3b3015.0080.GAE@google.com>
Subject: Re: [syzbot] [media] BUG: corrupted list in io_poll_remove_entries
From: syzbot <syzbot+ab12f0c08dd7ab8d057c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ab12f0c08dd7ab8d057c@syzkaller.appspotmail.com
Tested-by: syzbot+ab12f0c08dd7ab8d057c@syzkaller.appspotmail.com

Tested on:

commit:         05f7e89a Linux 6.19
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15956a52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671
dashboard link: https://syzkaller.appspot.com/bug?extid=ab12f0c08dd7ab8d057c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17da94aa580000

Note: testing is done by a robot and is best-effort only.
