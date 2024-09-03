Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69C1B12CE
	for <linux-media@vger.kernel.org>; Tue,  3 Sep 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361581; cv=none; b=lha2WjNZtzsdvIJKgVGI3jRNqgeN5NlLaQMJCogQfXIHQh+eAue+N81GtCkxz8JMsz61uajsLe2qxPi2aPV7gDWgIuU8u9AZZwPoBBuXe8NJHkq7m5Kpt0joQ3J6W0BYTmY+9GuT5m0A5e3y2CeRol1abSSx5koKYkQvnaATYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361581; c=relaxed/simple;
	bh=VonzwZ0E85qr77ls2VsNiUQ5wfLU6UqpjWRDPohGlU0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LayUZkXwX7q7DK7M5HJcsSbiR5+G+sZvvknE1rSFOYqnh0FxZbkJcY2UNw44etAWAPDg5jR/24g/eS9YLTz5eNPclIsjKslf5GYAYAs+6D+JIJuPfSv5962sxVVwxWz6qxDQfikkJ8G4c81ADvDD1dDzqPp1Qc6bbwY/T8aZndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtv.org; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from builder.linuxtv.org ([140.211.167.10])
	by linuxtv.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1slRMX-00080U-0O;
	Tue, 03 Sep 2024 11:06:17 +0000
Received: from localhost ([127.0.0.1] helo=builder.linuxtv.org)
	by builder.linuxtv.org with esmtp (Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1slRMX-008PBt-08;
	Tue, 03 Sep 2024 11:06:17 +0000
Date: Tue, 3 Sep 2024 11:06:16 +0000 (UTC)
From: Jenkins Builder Robot  <jenkins@linuxtv.org>
To: mchehab@kernel.org, linux-media@vger.kernel.org
Message-ID: <192833740.2.1725361577015@builder.linuxtv.org>
In-Reply-To: <149227735.1.1725360437778@builder.linuxtv.org>
References: <149227735.1.1725360437778@builder.linuxtv.org>
Subject: Jenkins build is back to normal : edid-decode #332
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Instance-Identity: MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApAf928QubrKEjMQ0IZR0WWXn8zG7uTdH33F2Idx4Xmlp6Z138NdNMQYNG71OKzmvn3/E1G4rpd9JsMls16nRZ2NAPgOWX0qfFr6HyOoQklLGZt+vkOFb0BvmBFfdI+00J5B1SPupxv4pT3bDLSiwbBNCOLY4sdB0gG1ng14mzu47G8zmH6l2ZE/9urEd6OLFhzrb6ym4vlkCE8uvNJAdAWbeafd1plHSLdU/TVqHMZELuM0wt9khqhUOkfE+dHr7h6DNrkFpvm/8j/5wTuy98ZwwWimP+pfjSQMgKrhXjwHcJJa2N9v1HdwrwlUaRYuA6o8fwUHNC9vLj7cCXM3qiwIDAQAB
X-Jenkins-Job: edid-decode
X-Jenkins-Result: SUCCESS
Auto-submitted: auto-generated

See <https://builder.linuxtv.org/job/edid-decode/332/display/redirect>

