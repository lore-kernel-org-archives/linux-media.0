Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Nyljjt6r"
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B610E4
	for <linux-media@vger.kernel.org>; Fri,  1 Dec 2023 22:44:50 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BE82F8642A;
	Sat,  2 Dec 2023 07:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701499488;
	bh=foax5Btl+NKy2C91ZLd4ufX3QwCqu6cTYbXJBTN66d8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nyljjt6rzMeRbOJ8pLRuLjHDJR6xQl/Oy1slpsgprBcfyJ75sK0hZialA24rRnGnB
	 7Fqlq2kyW2t8nB5qZWD/RPFZpHYtv3x1E5vyJ/IZqW3oojZkG2j8x3kwOqV3xJL4q5
	 maZ+ob2FZcNZIkhJuA85kgHh9mlsP9ndA5bKbj1qf6c/vpTZ++4dXe8S+6WzWwYCI0
	 /IwE6GRq4yviC2FY6NUbGWab+8HoHjeCP1I3RysZS+wivPsP6UUTbQP1FgiL6jzgjh
	 QKsDStCLUnTFX38p9XUFGuC7FuOa0ohGMin0IjH4Vjj4kzVmXhpjKAaY+92409hlKh
	 3Ro+IlxkSO5Ug==
Message-ID: <890ae113-7c7f-4214-9b00-ce00fc570567@denx.de>
Date: Sat, 2 Dec 2023 07:44:47 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: nxp: isi: Check whether pad is non-NULL before
 access
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-media@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20231201150614.63300-1-marex@denx.de>
 <CAOMZO5BssVez71=uCYd0XhL02xd1TrUyTzCc1fq_sWfENLaoTA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5BssVez71=uCYd0XhL02xd1TrUyTzCc1fq_sWfENLaoTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/2/23 03:27, Fabio Estevam wrote:
> On Fri, Dec 1, 2023 at 12:06 PM Marek Vasut <marex@denx.de> wrote:
> 
>>          pad = media_pad_remote_pad_first(&xbar->pads[sink_pad]);
>> -       sd = media_entity_to_v4l2_subdev(pad->entity);
>> +       if (!pad) {
>> +               dev_dbg(xbar->isi->dev,
> 
> Maybe dev_err() here instead?

That dev_dbg() is aligned with the prints in the rest of the function 
and it's not like kernel should do dev_err() into kernel log every time 
userspace does something wrong.

> Anyway:
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks !
