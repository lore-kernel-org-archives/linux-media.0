Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAZw09YZ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4F3271E
	for <linux-media@vger.kernel.org>; Fri, 17 Nov 2023 13:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700255926; x=1731791926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=POoYBdJdltRS6aK9DO9JNKMi0pPUBNiePRNcaU1VE0E=;
  b=EAZw09YZDps/TnSFD3RjrzNzPZOSNGlfx/rfB8FtSct+7oQ9QzynWVGB
   1xZ71puhhbJC/hoH1IiV6HcCcGDuDe+CdLurioTUkHTCOjwD4T3guwLZ2
   3z0cSu7Y2rJUJDlOK5Sq2ifPqafPEEZBjYo1Q4y2u9sI2ukWai8tp1USy
   Tup27c49NXwEDCzl3xlZDQiIkglKhXEh+rP4N/L+zYoE82wyQNlF0ta4a
   dhJk+E0iYJ/M6QNURz1IJGWfmLnzmYB1IxnV5jZQnmexpQnST0xelL3jT
   wPFLSVpwqFirJlbQi7NM7uRVuJiiqB47oxxvVrstyhruS6sPyGbVY2lrG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="381758764"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="381758764"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:18:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="800598921"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="800598921"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:18:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r46EA-0000000EuBW-2v7U;
	Fri, 17 Nov 2023 23:18:14 +0200
Date: Fri, 17 Nov 2023 23:18:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andreas Helbech Kleist <andreaskleist@gmail.com>,
	Hans de Goede <hans@hansg.org>, bingbu.cao@intel.com,
	linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com, ilpo.jarvinen@linux.intel.com,
	claus.stovgaard@gmail.com, tfiga@chromium.org,
	senozhatsky@chromium.org, tomi.valkeinen@ideasonboard.com,
	bingbu.cao@linux.intel.com, tian.shu.qiu@intel.com,
	hongju.wang@intel.com
Subject: Re: [PATCH v2 01/15] media: intel/ipu6: add Intel IPU6 PCI device
 driver
Message-ID: <ZVfYltUAZmVRatMS@smile.fi.intel.com>
References: <20231024112924.3934228-1-bingbu.cao@intel.com>
 <20231024112924.3934228-2-bingbu.cao@intel.com>
 <a3184b70-e0b3-4227-94af-2412fd565724@hansg.org>
 <d9fa902626486899929202f56f3e924b4ba27a73.camel@gmail.com>
 <65475a54-5b97-4c60-a55b-dedb66a02cbb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65475a54-5b97-4c60-a55b-dedb66a02cbb@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 17, 2023 at 07:43:04PM +0100, Hans de Goede wrote:
> On 11/8/23 15:10, Andreas Helbech Kleist wrote:
> > On Wed, 2023-11-08 at 12:25 +0100, Hans de Goede wrote:
> >> On 10/24/23 13:29, bingbu.cao@intel.com wrote:

...

>  	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_MSI);
> -	if (ret)
> +	if (ret < 0) {
>  		dev_err_probe(&dev->dev, ret, "Request msi failed");
> +		return ret;

Even further:

		return dev_err_probe(&dev->dev, ret, "Request msi failed");

> +	}

-- 
With Best Regards,
Andy Shevchenko


