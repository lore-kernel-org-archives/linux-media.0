Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055482ED17A
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807917; cv=none; b=UUMxC/YF8TRyFMVxbymtH7ktS3yHfeACe9DimH4diNsrTbSnWHVMQMD2gc4XLvtCCel4J2FLpdt+FvpMHGextkDfpzpaR9iOV4P/C/W5t+OEdqSdBLUxMZMBSs9gG5i98vqfhKV54DO9kuMZYJ06LV2sKNGBzxOQ/W8DLCoppJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807917; c=relaxed/simple;
	bh=msSa+ZN/cBDiQjQWcQiU9Jyh9ysAaSXK9U7nsPEiWiM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n+r3bCz3bOgms+6UIJa6Um3mAkLRcN60rkN/HAtpMjvKFKupsqapbchBi3YQ0xLvhXjREXvsIlDs4o06oH3oscOtokrW++Cmcs3bzv1ZdweSjntJe6KRr7PTjcQNvpqTyl6/aFozbGqV47/+RPa33jykB1Np5pQ8HzPNhamihSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=E/XNIqC1; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="E/XNIqC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1762807465; bh=msSa+ZN/cBDiQjQWcQiU9Jyh9ysAaSXK9U7nsPEiWiM=;
	h=Date:From:To:Cc:Subject:From;
	b=E/XNIqC1LOngEIpcXf9jfrvOlzurQ2QOqc521xyme70NcoSK7E8A1loiMkLiBFpNJ
	 E/cWYtbm3Zi5csb7BV2qSi1Hl0IvJdXE/gPNcdHshPMGeACHETeyR0850ZnmakqoTb
	 rO/nuW6IbSIbELtraW+Rw0+T3j+KO+YpgKdZy4Ox1aj/od208AF/9tZioFqEr3wXSX
	 wq97uaenzXNHy6bV4I8wYEr63PTky5zMexKGBFeAJgLjhS+wWC+h0bcgGNpbpKSwp6
	 IEAAyx8z/+gZ/TyKptKdjWVM1RWm03t5Qbn9T/EGRsAzq9CQ2HRqOWxalsZzS2Y9pg
	 94zJxCZWke+pg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 27C1E1003DF; Mon, 10 Nov 2025 20:44:25 +0000 (GMT)
Date: Mon, 10 Nov 2025 20:44:24 +0000
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Haotian Zhang <vulab@iscas.ac.cn>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Johan Hovold <johan@kernel.org>
Subject: [GIT PULL FOR 6.19] Rc fixes
Message-ID: <aRJOqJF9nJGgBdhO@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans, Mauro,

Just some small fixes.

Many thanks,

Sean

The following changes since commit b4fbb13db86adb0bae1d7f968b61ea8dc9635e33:

  media: qcom: camss: Add support for MSM8939 (2025-11-06 12:43:56 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/seanyoung tags/v6.19a

for you to fetch changes up to 370a7a6e77af43ea949710fd1919b8d6fb2b187e:

  media: siano: Remove redundant ternary operators (2025-11-10 10:42:48 +0000)

----------------------------------------------------------------
v6.19a

----------------------------------------------------------------
Haotian Zhang (1):
      media: rc: st_rc: Fix reset control resource leak

Johan Hovold (1):
      media: ir-hix5hd2: Drop unused module alias

Liao Yuanhong (1):
      media: siano: Remove redundant ternary operators

 drivers/media/common/siano/smsir.c | 2 +-
 drivers/media/rc/ir-hix5hd2.c      | 1 -
 drivers/media/rc/st_rc.c           | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
