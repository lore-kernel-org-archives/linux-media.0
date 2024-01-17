Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AD219F4
	for <linux-media@vger.kernel.org>; Wed, 17 Jan 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503758; cv=none; b=Iqjye7r8i8VgOqaaa9VReamS15o43IktrhCcnx0UxfQ4/r9d5JJkWyC0OQPxwWU8Qv5dI2AxwiNFyLPv7rbx7n6lU9CzIs3L1puxz+9isLWgc2Gz+MjDHxryNI9fHXqM0+2uOBwYy/w/l45ZZU2gs2dUB+ezCpCfZM61OQk0vvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503758; c=relaxed/simple;
	bh=nMLtIwps1Se+QGG7M25eCIEfQ7xv5fEJt38g+ON2m8s=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=EmnOiBC080ImDSj7Nl9wdK2Ef/2eLm2ppdcDnkvgSggyekwcYFbcSV4Jl9nirlZpyVFSrAoX4Eqs8oZq1FZgiRgSwGUVUv5dr72iuu2X+R9gOeyvoLDKFAfv3UY+nV4Md5M19fiNnkwzfqq7fkYr50XcYV8s6+ZZHWo9bKa0Xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887C5C433C7;
	Wed, 17 Jan 2024 15:02:37 +0000 (UTC)
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: linux-media@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH 00/10] v4l-utils: add v4l-audioX support
Date: Wed, 17 Jan 2024 16:02:08 +0100
Message-ID: <20240117150232.1800006-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for v4l-audioX M2M devices.

I think this is pretty complete, and it now has support for
fixed point control values as well.

You can find the git branch here:

https://git.linuxtv.org/hverkuil/v4l-utils.git/log/?h=audio

Regards,

        Hans


