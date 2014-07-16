package zebra.system.globalization 
{
	import flash.system.Capabilities;

	public class CultureInfo 
	{
		
		public function CultureInfo() 
		{
			
		}
		
		 private var _currentLanguage:uint = international;
		 public function set currentLanguage(value:uint):void {
											_currentLanguage = value;
											}
		 public function get currentLanguage():uint { return _currentLanguage; } 
		
		//language
		 public function  get LocalLanguage():String {
			return  Capabilities.language;
			}
		
		
		/**
		 * 国际
		 */
		static public const international:uint = 0x007F;
		 
		/**
		 * 南非荷兰语 
		 **/
		static public const af :uint = 0x0036 
		/**
		 * 南非荷兰语 - 南非 
		 **/
		static public const af_ZA :uint = 0x0436 
		/**
		 * 阿尔巴尼亚语 
		 **/
		static public const sq :uint = 0x001C 
		/**
		 * 阿尔巴尼亚语 - 阿尔巴尼亚 
		 **/
		static public const sq_AL :uint = 0x041C 
		/**
		 * 阿拉伯语 
		 **/
		static public const ar :uint = 0x0001 
		/**
		 * 阿拉伯语 - 阿尔及利亚 
		 **/
		static public const ar_DZ :uint = 0x1401 
		/**
		 * 阿拉伯语 - 巴林 
		 **/
		static public const ar_BH :uint = 0x3C01 
		/**
		 * 阿拉伯语 - 埃及 
		 **/
		static public const ar_EG :uint = 0x0C01 
		/**
		 * 阿拉伯语 - 伊拉克 
		 **/
		static public const ar_IQ :uint = 0x0801 
		/**
		 * 阿拉伯语 - 约旦 
		 **/
		static public const ar_JO :uint = 0x2C01 
		/**
		 * 阿拉伯语 - 科威特 
		 **/
		static public const ar_KW :uint = 0x3401 
		/**
		 * 阿拉伯语 - 黎巴嫩 
		 **/
		static public const ar_LB :uint = 0x3001 
		/**
		 * 阿拉伯语 - 利比亚 
		 **/
		static public const ar_LY :uint = 0x1001 
		/**
		 * 阿拉伯语 - 摩洛哥 
		 **/
		static public const ar_MA :uint = 0x1801 
		/**
		 * 阿拉伯语 - 阿曼 
		 **/
		static public const ar_OM :uint = 0x2001 
		/**
		 * 阿拉伯语 - 卡塔尔 
		 **/
		static public const ar_QA :uint = 0x4001 
		/**
		 * 阿拉伯语 - 沙特阿拉伯 
		 **/
		static public const ar_SA :uint = 0x0401 
		/**
		 * 阿拉伯语 - 叙利亚 
		 **/
		static public const ar_SY :uint = 0x2801 
		/**
		 * 阿拉伯语 - 突尼斯 
		 **/
		static public const ar_TN :uint = 0x1C01 
		/**
		 * 阿拉伯语 - 阿拉伯联合酋长国 
		 **/
		static public const ar_AE :uint = 0x3801 
		/**
		 * 阿拉伯语 - 也门 
		 **/
		static public const ar_YE :uint = 0x2401 
		/**
		 * 亚美尼亚语 
		 **/
		static public const hy :uint = 0x002B 
		/**
		 * 亚美尼亚语 - 亚美尼亚 
		 **/
		static public const hy_AM :uint = 0x042B 
		/**
		 * 阿泽里语 
		 **/
		static public const az :uint = 0x002C 
		/**
		 * 阿泽里语（西里尔语）- 阿塞拜疆 
		 **/
		static public const az_AZ_Cyrl :uint = 0x082C 
		/**
		 * 阿泽里语（拉丁）- 阿塞拜疆 
		 **/
		static public const az_AZ_Latn :uint = 0x042C 
		/**
		 * 巴斯克语 
		 **/
		static public const eu :uint = 0x002D 
		/**
		 * 巴斯克语 - 巴斯克地区 
		 **/
		static public const eu_ES :uint = 0x042D 
		/**
		 * 白俄罗斯语 
		 **/
		static public const be :uint = 0x0023 
		/**
		 * 白俄罗斯语 - 白俄罗斯 
		 **/
		static public const be_BY :uint = 0x0423 
		/**
		 * 保加利亚语 
		 **/
		static public const bg :uint = 0x0002 
		/**
		 * 保加利亚语 - 保加利亚 
		 **/
		static public const bg_BG :uint = 0x0402 
		/**
		 * 加泰罗尼亚语 
		 **/
		static public const ca :uint = 0x0003 
		/**
		 * 加泰罗尼亚语 - 加泰罗尼亚地区 
		 **/
		static public const ca_ES :uint = 0x0403 
		/**
		 * 中文 - 香港特别行政区 
		 **/
		static public const zh_HK :uint = 0x0C04 
		/**
		 * 中文 - 澳门特别行政区 
		 **/
		static public const zh_MO :uint = 0x1404 
		/**
		 * 中文 - 中国 
		 **/
		static public const zh_CN :uint = 0x0804 
		/**
		 * 中文（简体） 
		 **/
		static public const zh_CHS :uint = 0x0004 
		/**
		 * 中文 - 新加坡 
		 **/
		static public const zh_SG :uint = 0x1004 
		/**
		 * 中文 - 台湾 
		 **/
		static public const zh_TW :uint = 0x0404 
		/**
		 * 中文（繁体） 
		 **/
		static public const zh_CHT :uint = 0x7C04 
		/**
		 * 克罗地亚语 
		 **/
		static public const hr :uint = 0x001A 
		/**
		 * 克罗地亚语 - 克罗地亚 
		 **/
		static public const hr_HR :uint = 0x041A 
		/**
		 * 捷克语 
		 **/
		static public const cs :uint = 0x0005 
		/**
		 * 捷克语 - 捷克共和国 
		 **/
		static public const cs_CZ :uint = 0x0405 
		/**
		 * 丹麦语 
		 **/
		static public const da :uint = 0x0006 
		/**
		 * 丹麦语 - 丹麦 
		 **/
		static public const da_DK :uint = 0x0406 
		/**
		 * 马尔代夫语 
		 **/
		static public const div :uint = 0x0065 
		/**
		 * 马尔代夫语 - 马尔代夫 
		 **/
		static public const div_MV :uint = 0x0465 
		/**
		 * 荷兰语 
		 **/
		static public const nl :uint = 0x0013 
		/**
		 * 荷兰语 - 比利时 
		 **/
		static public const nl_BE :uint = 0x0813 
		/**
		 * 荷兰语 - 荷兰 
		 **/
		static public const nl_NL :uint = 0x0413 
		/**
		 * 英语 
		 **/
		static public const en :uint = 0x0009 
		/**
		 * 英语 - 澳大利亚 
		 **/
		static public const en_AU :uint = 0x0C09 
		/**
		 * 英语 - 伯利兹 
		 **/
		static public const en_BZ :uint = 0x2809 
		/**
		 * 英语 - 加拿大 
		 **/
		static public const en_CA :uint = 0x1009 
		/**
		 * 英语 - 加勒比 
		 **/
		static public const en_CB :uint = 0x2409 
		/**
		 * 英语 - 爱尔兰 
		 **/
		static public const en_IE :uint = 0x1809 
		/**
		 * 英语 - 牙买加 
		 **/
		static public const en_JM :uint = 0x2009 
		/**
		 * 英语 - 新西兰 
		 **/
		static public const en_NZ :uint = 0x1409 
		/**
		 * 英语 - 菲律宾 
		 **/
		static public const en_PH :uint = 0x3409 
		/**
		 * 英语 - 南非 
		 **/
		static public const en_ZA :uint = 0x1C09 
		/**
		 * 英语 - 特立尼达和多巴哥 
		 **/
		static public const en_TT :uint = 0x2C09 
		/**
		 * 英语 - 英国 
		 **/
		static public const en_GB :uint = 0x0809 
		/**
		 * 英语 - 美国 
		 **/
		static public const en_US :uint = 0x0409 
		/**
		 * 英语 - 津巴布韦 
		 **/
		static public const en_ZW :uint = 0x3009 
		/**
		 * 爱沙尼亚语 
		 **/
		static public const et :uint = 0x0025 
		/**
		 * 爱沙尼亚语 - 爱沙尼亚 
		 **/
		static public const et_EE :uint = 0x0425 
		/**
		 * 法罗语 
		 **/
		static public const fo :uint = 0x0038 
		/**
		 * 法罗语 - 法罗群岛 
		 **/
		static public const fo_FO :uint = 0x0438 
		/**
		 * 波斯语 
		 **/
		static public const fa :uint = 0x0029 
		/**
		 * 波斯语 - 伊朗 
		 **/
		static public const fa_IR :uint = 0x0429 
		/**
		 * 芬兰语 
		 **/
		static public const fi :uint = 0x000B 
		/**
		 * 芬兰语 - 芬兰 
		 **/
		static public const fi_FI :uint = 0x040B 
		/**
		 * 法语 
		 **/
		static public const fr :uint = 0x000C 
		/**
		 * 法语 - 比利时 
		 **/
		static public const fr_BE :uint = 0x080C 
		/**
		 * 法语 - 加拿大 
		 **/
		static public const fr_CA :uint = 0x0C0C 
		/**
		 * 法语 - 法国 
		 **/
		static public const fr_FR :uint = 0x040C 
		/**
		 * 法语 - 卢森堡 
		 **/
		static public const fr_LU :uint = 0x140C 
		/**
		 * 法语 - 摩纳哥 
		 **/
		static public const fr_MC :uint = 0x180C 
		/**
		 * 法语 - 瑞士 
		 **/
		static public const fr_CH :uint = 0x100C 
		/**
		 * 加利西亚语 
		 **/
		static public const gl :uint = 0x0056 
		/**
		 * 加利西亚语 - 加利西亚地区 
		 **/
		static public const gl_ES :uint = 0x0456 
		/**
		 * 格鲁吉亚语 
		 **/
		static public const ka :uint = 0x0037 
		/**
		 * 格鲁吉亚语 - 格鲁吉亚 
		 **/
		static public const ka_GE :uint = 0x0437 
		/**
		 * 德语 
		 **/
		static public const de :uint = 0x0007 
		/**
		 * 德语 - 奥地利 
		 **/
		static public const de_AT :uint = 0x0C07 
		/**
		 * 德语 - 德国 
		 **/
		static public const de_DE :uint = 0x0407 
		/**
		 * 德语 - 列支敦士登 
		 **/
		static public const de_LI :uint = 0x1407 
		/**
		 * 德语 - 卢森堡 
		 **/
		static public const de_LU :uint = 0x1007 
		/**
		 * 德语 - 瑞士 
		 **/
		static public const de_CH :uint = 0x0807 
		/**
		 * 希腊语 
		 **/
		static public const el :uint = 0x0008 
		/**
		 * 希腊语 - 希腊 
		 **/
		static public const el_GR :uint = 0x0408 
		/**
		 * 古吉拉特语 
		 **/
		static public const gu :uint = 0x0047 
		/**
		 * 古吉拉特语 - 印度 
		 **/
		static public const gu_IN :uint = 0x0447 
		/**
		 * 希伯来语 
		 **/
		static public const he :uint = 0x000D 
		/**
		 * 希伯来语 - 以色列 
		 **/
		static public const he_IL :uint = 0x040D 
		/**
		 * 印地语 
		 **/
		static public const hi :uint = 0x0039 
		/**
		 * 印地语 - 印度 
		 **/
		static public const hi_IN :uint = 0x0439 
		/**
		 * 匈牙利语 
		 **/
		static public const hu :uint = 0x000E 
		/**
		 * 匈牙利语 - 匈牙利 
		 **/
		static public const hu_HU :uint = 0x040E 
		/**
		 * 冰岛语 
		 **/
		static public const is_ :uint = 0x000F 
		/**
		 * 冰岛语 - 冰岛 
		 **/
		static public const is_IS :uint = 0x040F 
		/**
		 * 印度尼西亚语 
		 **/
		static public const id :uint = 0x0021 
		/**
		 * 印度尼西亚语 - 印度尼西亚 
		 **/
		static public const id_ID :uint = 0x0421 
		/**
		 * 意大利语 
		 **/
		static public const it :uint = 0x0010 
		/**
		 * 意大利语 - 意大利 
		 **/
		static public const it_IT :uint = 0x0410 
		/**
		 * 意大利语 - 瑞士 
		 **/
		static public const it_CH :uint = 0x0810 
		/**
		 * 日语 
		 **/
		static public const ja :uint = 0x0011 
		/**
		 * 日语 - 日本 
		 **/
		static public const ja_JP :uint = 0x0411 
		/**
		 * 卡纳达语 
		 **/
		static public const kn :uint = 0x004B 
		/**
		 * 卡纳达语 - 印度 
		 **/
		static public const kn_IN :uint = 0x044B 
		/**
		 * 哈萨克语 
		 **/
		static public const kk :uint = 0x003F 
		/**
		 * 哈萨克语 - 哈萨克斯坦 
		 **/
		static public const kk_KZ :uint = 0x043F 
		/**
		 * 贡根语 
		 **/
		static public const kok :uint = 0x0057 
		/**
		 * 贡根语 - 印度 
		 **/
		static public const kok_IN :uint = 0x0457 
		/**
		 * 朝鲜语 
		 **/
		static public const ko :uint = 0x0012 
		/**
		 * 朝鲜语 - 韩国 
		 **/
		static public const ko_KR :uint = 0x0412 
		/**
		 * 吉尔吉斯语 
		 **/
		static public const ky :uint = 0x0040 
		/**
		 * 吉尔吉斯语 - 吉尔吉斯坦 
		 **/
		static public const ky_KG :uint = 0x0440 
		/**
		 * 拉脱维亚语 
		 **/
		static public const lv :uint = 0x0026 
		/**
		 * 拉脱维亚语 - 拉脱维亚 
		 **/
		static public const lv_LV :uint = 0x0426 
		/**
		 * 立陶宛语 
		 **/
		static public const lt :uint = 0x0027 
		/**
		 * 立陶宛语 - 立陶宛 
		 **/
		static public const lt_LT :uint = 0x0427 
		/**
		 * 马其顿语 
		 **/
		static public const mk :uint = 0x002F 
		/**
		 * 马其顿语 - 前南斯拉夫联盟马其顿共和国 
		 **/
		static public const mk_MK :uint = 0x042F 
		/**
		 * 马来语 
		 **/
		static public const ms :uint = 0x003E 
		/**
		 * 马来语 - 文莱 
		 **/
		static public const ms_BN :uint = 0x083E 
		/**
		 * 马来语 - 马来西亚 
		 **/
		static public const ms_MY :uint = 0x043E 
		/**
		 * 马拉地语 
		 **/
		static public const mr :uint = 0x004E 
		/**
		 * 马拉地语 - 印度 
		 **/
		static public const mr_IN :uint = 0x044E 
		/**
		 * 蒙古语 
		 **/
		static public const mn :uint = 0x0050 
		/**
		 * 蒙古语 - 蒙古 
		 **/
		static public const mn_MN :uint = 0x0450 
		/**
		 * 挪威语 
		 **/
		static public const no :uint = 0x0014 
		/**
		 * 挪威语（伯克梅尔）- 挪威 
		 **/
		static public const nb_NO :uint = 0x0414 
		/**
		 * 挪威语（尼诺斯克）- 挪威 
		 **/
		static public const nn_NO :uint = 0x0814 
		/**
		 * 波兰语 
		 **/
		static public const pl :uint = 0x0015 
		/**
		 * 波兰语 - 波兰 
		 **/
		static public const pl_PL :uint = 0x0415 
		/**
		 * 葡萄牙语 
		 **/
		static public const pt :uint = 0x0016 
		/**
		 * 葡萄牙语 - 巴西 
		 **/
		static public const pt_BR :uint = 0x0416 
		/**
		 * 葡萄牙语 - 葡萄牙 
		 **/
		static public const pt_PT :uint = 0x0816 
		/**
		 * 旁遮普语 
		 **/
		static public const pa :uint = 0x0046 
		/**
		 * 旁遮普语 - 印度 
		 **/
		static public const pa_IN :uint = 0x0446 
		/**
		 * 罗马尼亚语 
		 **/
		static public const ro :uint = 0x0018 
		/**
		 * 罗马尼亚语 - 罗马尼亚 
		 **/
		static public const ro_RO :uint = 0x0418 
		/**
		 * 俄语 
		 **/
		static public const ru :uint = 0x0019 
		/**
		 * 俄语 - 俄罗斯 
		 **/
		static public const ru_RU :uint = 0x0419 
		/**
		 * 梵语 
		 **/
		static public const sa :uint = 0x004F 
		/**
		 * 梵语 - 印度 
		 **/
		static public const sa_IN :uint = 0x044F 
		/**
		 * 塞尔维亚语（西里尔语）- 塞尔维亚 
		 **/
		static public const sr_SP_Cyrl :uint = 0x0C1A 
		/**
		 * 塞尔维亚语（拉丁）- 塞尔维亚 
		 **/
		static public const sr_SP_Latn :uint = 0x081A 
		/**
		 * 斯洛伐克语 
		 **/
		static public const sk :uint = 0x001B 
		/**
		 * 斯洛伐克语 - 斯洛伐克 
		 **/
		static public const sk_SK :uint = 0x041B 
		/**
		 * 斯洛文尼亚语 
		 **/
		static public const sl :uint = 0x0024 
		/**
		 * 斯洛文尼亚语 - 斯洛文尼亚 
		 **/
		static public const sl_SI :uint = 0x0424 
		/**
		 * 西班牙语 
		 **/
		static public const es :uint = 0x000A 
		/**
		 * 西班牙语 - 阿根廷 
		 **/
		static public const es_AR :uint = 0x2C0A 
		/**
		 * 西班牙语 - 玻利维亚 
		 **/
		static public const es_BO :uint = 0x400A 
		/**
		 * 西班牙语 - 智利 
		 **/
		static public const es_CL :uint = 0x340A 
		/**
		 * 西班牙语 - 哥伦比亚 
		 **/
		static public const es_CO :uint = 0x240A 
		/**
		 * 西班牙语 - 哥斯达黎加 
		 **/
		static public const es_CR :uint = 0x140A 
		/**
		 * 西班牙语 - 多米尼加共和国 
		 **/
		static public const es_DO :uint = 0x1C0A 
		/**
		 * 西班牙语 - 厄瓜多尔 
		 **/
		static public const es_EC :uint = 0x300A 
		/**
		 * 西班牙语 - 萨尔瓦多 
		 **/
		static public const es_SV :uint = 0x440A 
		/**
		 * 西班牙语 - 危地马拉 
		 **/
		static public const es_GT :uint = 0x100A 
		/**
		 * 西班牙语 - 洪都拉斯 
		 **/
		static public const es_HN :uint = 0x480A 
		/**
		 * 西班牙语 - 墨西哥 
		 **/
		static public const es_MX :uint = 0x080A 
		/**
		 * 西班牙语 - 尼加拉瓜 
		 **/
		static public const es_NI :uint = 0x4C0A 
		/**
		 * 西班牙语 - 巴拿马 
		 **/
		static public const es_PA :uint = 0x180A 
		/**
		 * 西班牙语 - 巴拉圭 
		 **/
		static public const es_PY :uint = 0x3C0A 
		/**
		 * 西班牙 - 秘鲁 
		 **/
		static public const es_PE :uint = 0x280A 
		/**
		 * 西班牙语 - 波多黎各 
		 **/
		static public const es_PR :uint = 0x500A 
		/**
		 * 西班牙语 - 西班牙 
		 **/
		static public const es_ES :uint = 0x0C0A 
		/**
		 * 西班牙语 - 乌拉圭 
		 **/
		static public const es_UY :uint = 0x380A 
		/**
		 * 西班牙语 - 委内瑞拉 
		 **/
		static public const es_VE :uint = 0x200A 
		/**
		 * 斯瓦希里语 
		 **/
		static public const sw :uint = 0x0041 
		/**
		 * 斯瓦希里语 - 肯尼亚 
		 **/
		static public const sw_KE :uint = 0x0441 
		/**
		 * 瑞典语 
		 **/
		static public const sv :uint = 0x001D 
		/**
		 * 瑞典语 - 芬兰 
		 **/
		static public const sv_FI :uint = 0x081D 
		/**
		 * 瑞典语 - 瑞典 
		 **/
		static public const sv_SE :uint = 0x041D 
		/**
		 * 叙利亚语 
		 **/
		static public const syr :uint = 0x005A 
		/**
		 * 叙利亚语 - 叙利亚 
		 **/
		static public const syr_SY :uint = 0x045A 
		/**
		 * 泰米尔语 
		 **/
		static public const ta :uint = 0x0049 
		/**
		 * 泰米尔语 - 印度 
		 **/
		static public const ta_IN :uint = 0x0449 
		/**
		 * 鞑靼语 
		 **/
		static public const tt :uint = 0x0044 
		/**
		 * 鞑靼语 - 俄罗斯 
		 **/
		static public const tt_RU :uint = 0x0444 
		/**
		 * 泰卢固语 
		 **/
		static public const te :uint = 0x004A 
		/**
		 * 泰卢固语 - 印度 
		 **/
		static public const te_IN :uint = 0x044A 
		/**
		 * 泰语 
		 **/
		static public const th :uint = 0x001E 
		/**
		 * 泰语 - 泰国 
		 **/
		static public const th_TH :uint = 0x041E 
		/**
		 * 土耳其语 
		 **/
		static public const tr :uint = 0x001F 
		/**
		 * 土耳其语 - 土耳其 
		 **/
		static public const tr_TR :uint = 0x041F 
		/**
		 * 乌克兰语 
		 **/
		static public const uk :uint = 0x0022 
		/**
		 * 乌克兰语 - 乌克兰 
		 **/
		static public const uk_UA :uint = 0x0422 
		/**
		 * 乌尔都语 
		 **/
		static public const ur :uint = 0x0020 
		/**
		 * 乌尔都语 - 巴基斯坦 
		 **/
		static public const ur_PK :uint = 0x0420 
		/**
		 * 乌兹别克语 
		 **/
		static public const uz :uint = 0x0043 
		/**
		 * 乌兹别克语（西里尔语）- 乌兹别克斯坦 
		 **/
		static public const uz_UZ_Cyrl :uint = 0x0843 
		/**
		 * 乌兹别克语（拉丁）- 乌兹别克斯坦 
		 **/
		static public const uz_UZ_Latn :uint = 0x0443 
		/**
		 * 越南语 
		 **/
		static public const vi :uint = 0x002A 
		/**
		 * 越南语 - 越南 
		 **/
		static public const vi_VN :uint = 0x042A 


	}

}
