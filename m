Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088971F3FE2
	for <linux-media@vger.kernel.org>; Sat,  8 Nov 2025 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762644738; cv=none; b=LFaVcwv9uSxzRXH7Vz/kppJ5aMw4zomYHh6OePLvsZGOKjezVPOVK+2FWWy68MtpaWY9+k4tSit1QVE98EZi5RtpVNVW9l6dfVF+slc2mRmxjdec2EHlDCedYPxYl3MNxm9ljHnbC3gXwSIL6n7fQiiuuzEzp94+c4ToRelmB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762644738; c=relaxed/simple;
	bh=xKs8wYkk+cdW/0EbGiN/udJKAvFLzY1GYmzjS/+rDlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEDvmpHr0loFaBEPMZ8C7492/koNxYgvw6D5t79ZXS37D9Y+lePqgA3lNpvE2ssmLoxJ87FT4lR6Lae7nQ5zshojs24nVhtgxoO9ujYpi2ipZ2MWSVzCb91nZLfZTB7g8clTi1s9OitWWVRYrKPwEzLNPSvYLop/HPiZgIqTnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVx2PyO+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVx2PyO+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782e93932ffso1542753b3a.3
        for <linux-media@vger.kernel.org>; Sat, 08 Nov 2025 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762644736; x=1763249536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2fxYKfyTmTI/AxonjY+SqxajrG2P4Kjo61uGzKE6W8=;
        b=bVx2PyO+GbGyv/co34eemITrgkf82Ln62iuzCZizLsMg24H5pBex2AdDJ5TqG3r2Si
         KCvBDZRwHOHkDxwkVelYipdWzQzBHRfLfWEFEaJvzdUw5RHdcatL8OBfm6Ug7HtvMOmE
         Dj2EuN0QdjTN9oq703vDEtQpe2zOLOd1KOLke4MFPE/k5z+uiAxcSqoNxw3Ej/9LnGyc
         J+YHERMJzscwaDOxHApjMPjo04bq8M5r3okSo6e9S19B5M9trKDjm9Kv1fcwS0DxB3AI
         +8iRlFgmkWHeumpAG1Y2g7/7vqDYCYKu4sJKHqeE/PlZJ9QRB0KEbl2mZUjWM/dGmKtg
         3mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762644736; x=1763249536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2fxYKfyTmTI/AxonjY+SqxajrG2P4Kjo61uGzKE6W8=;
        b=IASOg3p+ueVngtGjlFBMWdh1T277TLA4b6e0/WV2l4ijLbjvptoeU3v2cqB/2dW/IJ
         zkj7B3SIAEkVuxGOU63cHmhjpOA4J0OCXgBzzjj0j2tXW2JW6vukA4kp8ePgmeOyOneX
         09BJivWAy3IrCNhEU467rc9FkQlUhbooehFh8PGZ0u4DHcaCJ7OdTLsG9V5F7oNbO/0F
         mkUEKAHo8eRnNzdL/TMJ8KkwQzc0adIj1ydMbzrbmE6rdvE4Kf8LcwP6nLT8PDOutqLn
         faayyc+kgK2JSXELwVagonwFxWitzbAvo6x70Cc6SlNyXR0WsnxriVw8/yuxokYCSn57
         8uVw==
X-Forwarded-Encrypted: i=1; AJvYcCXbyUWih+QVLxsxXi3Z8bfJaO2aRMXU208oJfccppBTYbtCXnxUYdQQMS4iDXvdqOizuwDem77B/YrR9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIX473P1ouMYMmO4M03weDN3FPzyvc8LjDBul/nHoVsmV7JqeS
	QASW/O+8rXMJSgmTHekLStSKkyo/ww8FjAfSehhkHFbda2FUH45c3a83
X-Gm-Gg: ASbGnctFL2TGYs89rmehIS79AR34NwtKc8amb5cMDS9gLoiipwYsMhoMfKMgf+jQvTE
	TUCWgfERezuKoB8stcJdnpskrsE0+ZgSlb1eBv9UFrp+B5maSBXULa+wUq0QMaATAIGprcZALZY
	xTq7Rh7pw+XAAaHwD35dK/W8U+YlYMAzQkuI05JCd+VX2XKCgSWJkb/niYGO/FvKVPG9NjNBzDo
	TfemaJ3T9FCN4pvCkfyaUMG5mvKXccx3u4/hd7iHQIvWJAHJ+agp1RnNwJ1rjMXPWWfpjoGVJPM
	AnW9pzwAPzqcxM4p+6DZXdF0cur1wTTcOn6Z/UaYt6Q4pjB1i1+kR3hSfJYHLsf4G4gpGRqBuyU
	Vb+syM77Axy43n4txfv4wj84EpFj52arf9h6e4/r45GlkNa9SvSkGSuH7AKJ14lp99t01aqT1VP
	es
X-Google-Smtp-Source: AGHT+IHt0Vn3SiG3I6Pw+8+ukG4cQ6WeXSBHOSQlHyfoi+jjU2LC0v/ov1yYPZ3yv8FjxrEwPlJ0Ug==
X-Received: by 2002:a17:90b:5710:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3436cd0f1f0mr5195603a91.36.1762644736252;
        Sat, 08 Nov 2025 15:32:16 -0800 (PST)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436d76d382sm1343594a91.0.2025.11.08.15.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:32:16 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1 2/2] dt-bindings: media: i2c: et8ek8: document missing crc as optional property
Date: Sat,  8 Nov 2025 15:32:00 -0800
Message-ID: <20251108233200.2068334-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the optional crc property to the endpoint node for the et8ek8 sensor.
This property enables CRC checksums for the sensor bus and was added to
match the new driver support for reading it from the device tree.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 .../devicetree/bindings/media/i2c/toshiba,et8ek8.txt        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
index 8d8e40c56..5fd30f59b 100644
--- a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
+++ b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
@@ -30,6 +30,12 @@ Endpoint node mandatory properties
 - remote-endpoint: A phandle to the bus receiver's endpoint node.
 
 
+Endpoint node optional properties
+---------------------------------
+
+- crc: Enable CRC checksums.
+
+
 Example
 -------
 
-- 
2.51.0

