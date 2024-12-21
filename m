Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47853189F45;
	Sat, 21 Dec 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809385; cv=none; b=Duy+oIWlh8MmfJA1WwhGv+QE4QXshCZy1X7rJMC23GdHIR8P8cecoJl09aCzylGlGq6Tbq6ant+M3jXP5o7djfzd4hEPCcYGiEHcDBcDtOfmKp0cgrEKtqVamP49KhtGeL4sSJ4j5gBWxxitwLlWjwykJdIGaoMxhd8Ii3QqG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809385; c=relaxed/simple;
	bh=tvMJLdiVY+C9qRPQ8cprJ6KJl/Y9HQIih4YelqkwtU8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WAY5xNeM97BAUSrZOldfnpE8DrOrAIwvPqf4SQY8PGk3sOvsEEJl/JaauNRerCN6lCxYxOF6Y4qbngfgye0sGPKv9TAX5+Cp53MNQHP7cRFe+0GD5SVWOEvg6QirRIiXcnAVx9BcVnC4TPKIE2WZyGGeVDenBwcTKFG/HX7KVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUERnlIv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUERnlIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC6CC4CECE;
	Sat, 21 Dec 2024 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734809385;
	bh=tvMJLdiVY+C9qRPQ8cprJ6KJl/Y9HQIih4YelqkwtU8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fUERnlIvOjoTvsDAqKqR+medZWYBQjRYnnDGBQ5deR8eDEyQNJR8/n//wpKknqqZW
	 9gPAz7KF3CGKBgT4EqpXqtLQSV1Y8SOEiJM5w7oKFQ8VF7y22fv9/yj5fukiPs8EBC
	 XU1/GetFi9iKei4b3bBTQ3gBgG/MH1Q6RWXBB/G95KZxeGRzYYL8uNXI2g4zWSdjy1
	 bpWshFce8rcnF6IUUfwkC2htPxcB8dKJGczp5u7fwchNxSPiVca2HJXEDYyow4S51C
	 w6wnNqmsp4i8+aekR9hH9MUNNdGSRBOW0A4kd11weuDeuGFECmNQz2/TtODQD+jB1S
	 mjUv/Gkz5ZWIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D43806656;
	Sat, 21 Dec 2024 19:30:04 +0000 (UTC)
Subject: Re: [GIT PULL for v6.13-rc4] media fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241221142012.3f43a036@foz.lan>
References: <20241221142012.3f43a036@foz.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241221142012.3f43a036@foz.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git tags/media/v6.13-3
X-PR-Tracked-Commit-Id: 8b55f8818900c99dd4f55a59a103f5b29e41eb2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 876685ce5e1a5f8696a7124de9bfa0ffbbbd27ae
Message-Id: <173480940306.3212515.12832901171174526989.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2024 19:30:03 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sebastian Fricke <sebastian.fricke@collabora.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Dec 2024 14:20:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git tags/media/v6.13-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/876685ce5e1a5f8696a7124de9bfa0ffbbbd27ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
