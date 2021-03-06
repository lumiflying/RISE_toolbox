%% Code automagically generated by rise on 13-Jul-2013 13:47:20

function [G0,G1,G2,G3]=endo_exo(y,x,ss,param,def,s0,s1)

if nargout>0;
G0=sparse(11,1);
ref_0_1=y(5)+y(6);
ref_0_2=ref_0_1-y(11);
ref_0_3=y(2)*y(7);
ref_0_4=y(11)-ref_0_3;
ref_0_5=y(2)-param(1);
ref_0_6=y(13)-param(1);
ref_0_7=ref_0_6*param(18);
ref_0_8=param(23)*x(1);
ref_0_9=ref_0_7+ref_0_8;
ref_0_10=ref_0_5-ref_0_9;
ref_0_11=y(10)*y(11);
ref_0_12=y(3)*y(8);
ref_0_13=ref_0_11+ref_0_12;
ref_0_14=1-param(4);
ref_0_15=ref_0_14*y(14);
ref_0_16=ref_0_15+y(6);
ref_0_17=ref_0_16+y(12);
ref_0_18=ref_0_13-ref_0_17;
ref_0_19=y(3)/y(11);
ref_0_20=y(9)-ref_0_19;
ref_0_21=1-param(16);
ref_0_22=ref_0_21*param(30);
ref_0_23=param(16)*y(17);
ref_0_24=ref_0_22+ref_0_23;
ref_0_25=param(21)*x(3);
ref_0_26=ref_0_25+ref_0_24;
ref_0_27=y(4)-param(2);
ref_0_28=def(2)*ref_0_27;
ref_0_29=ref_0_28+ref_0_26;
ref_0_30=y(10)-ref_0_29;
ref_0_31=y(4)-ref_0_15;
ref_0_32=1-param(15);
ref_0_33=ref_0_32*param(7);
ref_0_34=param(15)*y(16);
ref_0_35=ref_0_33+ref_0_34;
ref_0_36=param(20)*x(2);
ref_0_37=ref_0_36+ref_0_35;
ref_0_38=def(1)*ref_0_27;
ref_0_39=ref_0_37-ref_0_38;
ref_0_40=y(6)-ref_0_39;
ref_0_41=y(12)-param(31);
ref_0_42=y(18)-param(31);
ref_0_43=ref_0_42*param(17);
ref_0_44=param(22)*x(4);
ref_0_45=ref_0_43+ref_0_44;
ref_0_46=ref_0_41-ref_0_45;
ref_0_47=param(10)*y(15);
ref_0_48=y(5)-ref_0_47;
ref_0_49=ref_0_48*param(13);
ref_0_50=1-y(7);
ref_0_51=ref_0_49/ref_0_50;
ref_0_52=1-y(10);
ref_0_53=ref_0_52*y(2);
ref_0_54=ref_0_51-ref_0_53;
ref_0_55=ref_0_14*param(3);
ref_0_56=ref_0_55*ref_0_48;
ref_0_57=param(10)*y(5);
ref_0_58=y(1)-ref_0_57;
ref_0_59=ref_0_56/ref_0_58;
ref_0_60=y(8)-ref_0_59;
ref_0_61=param(6)*y(9);
ref_0_62=ref_0_61+param(5);
ref_0_63=exp(ref_0_62);
ref_0_64=1+ref_0_63;
ref_0_65=ref_0_63/ref_0_64;
ref_0_66=1-ref_0_65;
ref_0_67=1-ref_0_66;
ref_0_68=if_elseif(s0==1&s1==1,ref_0_66,s0==1&s1==2,ref_0_65,s0==2&s1==1,ref_0_66,s0==2&s1==2,ref_0_67);
G0(1,1)=ref_0_68*ref_0_2;
G0(2,1)=ref_0_68*ref_0_4;
G0(3,1)=ref_0_68*ref_0_10;
G0(4,1)=ref_0_68*ref_0_18;
G0(5,1)=ref_0_68*ref_0_20;
G0(6,1)=ref_0_68*ref_0_30;
G0(7,1)=ref_0_68*ref_0_31;
G0(8,1)=ref_0_68*ref_0_40;
G0(9,1)=ref_0_68*ref_0_46;
G0(10,1)=ref_0_68*ref_0_54;
G0(11,1)=ref_0_68*ref_0_60;
end;
if nargout>1;
G1=sparse(11,37);
ref_1_80=-ref_0_56;
ref_1_81=ref_0_58^2;
ref_1_82=ref_1_80/ref_1_81;
ref_1_83=-ref_1_82;
G1(11,1)=ref_0_68*ref_1_83;
ref_1_85=-y(7);
G1(2,2)=ref_0_68*ref_1_85;
ref_1_87=-ref_0_52;
G1(10,2)=ref_0_68*ref_1_87;
G1(4,3)=ref_0_68*y(8);
ref_1_90=1/y(11);
ref_1_91=-ref_1_90;
G1(5,3)=ref_0_68*ref_1_91;
ref_1_93=-def(2);
G1(6,4)=ref_0_68*ref_1_93;
G1(8,4)=def(1)*ref_0_68;
ref_1_97=param(13)/ref_0_50;
G1(10,5)=ref_0_68*ref_1_97;
ref_1_99=-param(10);
ref_1_100=ref_0_55*ref_0_58;
ref_1_101=ref_0_56*ref_1_99;
ref_1_102=ref_1_100-ref_1_101;
ref_1_103=ref_1_102/ref_1_81;
ref_1_104=-ref_1_103;
G1(11,5)=ref_0_68*ref_1_104;
G1(4,6)=-ref_0_68;
ref_1_107=-y(2);
G1(2,7)=ref_0_68*ref_1_107;
ref_1_110=ref_0_50^2;
ref_1_111=ref_0_49/ref_1_110;
G1(10,7)=ref_0_68*ref_1_111;
G1(4,8)=ref_0_68*y(3);
ref_1_114=ref_0_63*param(6);
ref_1_115=ref_1_114*ref_0_64;
ref_1_116=ref_0_63*ref_1_114;
ref_1_117=ref_1_115-ref_1_116;
ref_1_118=ref_0_64^2;
ref_1_119=ref_1_117/ref_1_118;
ref_1_120=-ref_1_119;
ref_1_121=if_elseif(s0==1&s1==1,ref_1_120,s0==1&s1==2,ref_1_119,s0==2&s1==1,ref_1_120,s0==2&s1==2,ref_1_119);
G1(1,9)=ref_1_121*ref_0_2;
G1(2,9)=ref_1_121*ref_0_4;
G1(3,9)=ref_1_121*ref_0_10;
G1(4,9)=ref_1_121*ref_0_18;
ref_1_126=ref_1_121*ref_0_20;
G1(5,9)=ref_0_68+ref_1_126;
G1(6,9)=ref_1_121*ref_0_30;
G1(7,9)=ref_1_121*ref_0_31;
G1(8,9)=ref_1_121*ref_0_40;
G1(9,9)=ref_1_121*ref_0_46;
G1(10,9)=ref_1_121*ref_0_54;
G1(11,9)=ref_1_121*ref_0_60;
G1(4,10)=ref_0_68*y(11);
G1(10,10)=ref_0_68*y(2);
G1(4,11)=ref_0_68*y(10);
ref_1_137=-y(3);
ref_1_138=y(11)^2;
ref_1_139=ref_1_137/ref_1_138;
ref_1_140=-ref_1_139;
G1(5,11)=ref_0_68*ref_1_140;
ref_1_142=-param(18);
G1(3,13)=ref_0_68*ref_1_142;
ref_1_144=-ref_0_14;
G1(4,14)=ref_0_68*ref_1_144;
ref_1_146=param(13)*ref_1_99;
ref_1_147=ref_1_146/ref_0_50;
G1(10,15)=ref_0_68*ref_1_147;
ref_1_149=ref_0_55*ref_1_99;
ref_1_150=ref_1_149/ref_0_58;
ref_1_151=-ref_1_150;
G1(11,15)=ref_0_68*ref_1_151;
ref_1_153=-param(15);
G1(8,16)=ref_0_68*ref_1_153;
ref_1_155=-param(16);
G1(6,17)=ref_0_68*ref_1_155;
ref_1_157=-param(17);
G1(9,18)=ref_0_68*ref_1_157;
ref_1_159=-param(23);
G1(3,19)=ref_0_68*ref_1_159;
ref_1_161=-param(20);
G1(8,20)=ref_0_68*ref_1_161;
ref_1_163=-param(21);
G1(6,21)=ref_0_68*ref_1_163;
ref_1_165=-param(22);
G1(9,22)=ref_0_68*ref_1_165;
G1(1,5)=ref_0_68;
G1(1,6)=ref_0_68;
G1(1,11)=G1(4,6);
G1(2,11)=ref_0_68;
G1(3,2)=ref_0_68;
G1(4,12)=G1(4,6);
G1(6,10)=ref_0_68;
G1(7,4)=ref_0_68;
G1(7,14)=G1(4,14);
G1(8,6)=ref_0_68;
G1(9,12)=ref_0_68;
G1(11,8)=ref_0_68;
end;
if nargout>2;
G2=sparse(11,1369);
ref_2_168=2/ref_0_58;
ref_2_169=ref_2_168*ref_1_81;
ref_2_170=ref_2_169*ref_1_80;
ref_2_171=-ref_2_170;
ref_2_172=ref_1_81^2;
ref_2_173=ref_2_171/ref_2_172;
ref_2_174=-ref_2_173;
G2(11,1)=ref_0_68*ref_2_174;
ref_2_176=-ref_0_55;
ref_2_177=2*ref_1_99;
ref_2_178=ref_2_177/ref_0_58;
ref_2_179=ref_2_178*ref_1_81;
ref_2_180=ref_1_81*ref_2_176;
ref_2_181=ref_2_179*ref_1_80;
ref_2_182=ref_2_180-ref_2_181;
ref_2_183=ref_2_182/ref_2_172;
ref_2_184=-ref_2_183;
G2(11,2)=ref_0_68*ref_2_184;
G2(11,3)=ref_1_121*ref_1_83;
ref_2_187=-ref_1_149;
ref_2_188=ref_2_187/ref_1_81;
ref_2_189=-ref_2_188;
G2(11,4)=ref_0_68*ref_2_189;
G2(2,6)=ref_1_121*ref_1_85;
G2(10,6)=ref_1_121*ref_1_87;
G2(4,9)=ref_1_121*y(8);
G2(5,9)=ref_1_121*ref_1_91;
ref_2_195=-1/ref_1_138;
ref_2_196=-ref_2_195;
G2(5,10)=ref_0_68*ref_2_196;
G2(6,11)=ref_1_121*ref_1_93;
G2(8,11)=def(1)*ref_1_121;
ref_2_200=ref_2_179*ref_1_102;
ref_2_201=-ref_2_200;
ref_2_202=ref_2_201/ref_2_172;
ref_2_203=-ref_2_202;
G2(11,12)=ref_0_68*ref_2_203;
ref_2_206=param(13)/ref_1_110;
G2(10,13)=ref_0_68*ref_2_206;
G2(10,14)=ref_1_121*ref_1_97;
G2(11,14)=ref_1_121*ref_1_104;
ref_2_210=ref_1_149*ref_1_99;
ref_2_211=-ref_2_210;
ref_2_212=ref_2_211/ref_1_81;
ref_2_213=-ref_2_212;
G2(11,15)=ref_0_68*ref_2_213;
G2(4,16)=-ref_1_121;
ref_2_217=-2/ref_0_50;
ref_2_218=ref_2_217*ref_1_110;
ref_2_219=ref_2_218*ref_0_49;
ref_2_220=-ref_2_219;
ref_2_221=ref_1_110^2;
ref_2_222=ref_2_220/ref_2_221;
G2(10,17)=ref_0_68*ref_2_222;
G2(2,18)=ref_1_121*ref_1_107;
G2(10,18)=ref_1_121*ref_1_111;
ref_2_226=ref_1_146/ref_1_110;
G2(10,19)=ref_0_68*ref_2_226;
G2(4,20)=ref_1_121*y(3);
ref_2_229=ref_1_114*param(6);
ref_2_230=ref_2_229*ref_0_64;
ref_2_231=ref_1_114*ref_1_114;
ref_2_232=ref_2_230+ref_2_231;
ref_2_233=ref_0_63*ref_2_229;
ref_2_234=ref_2_231+ref_2_233;
ref_2_235=ref_2_232-ref_2_234;
ref_2_237=2*ref_1_114;
ref_2_238=ref_2_237/ref_0_64;
ref_2_239=ref_2_238*ref_1_118;
ref_2_240=ref_2_235*ref_1_118;
ref_2_241=ref_2_239*ref_1_117;
ref_2_242=ref_2_240-ref_2_241;
ref_2_243=ref_1_118^2;
ref_2_244=ref_2_242/ref_2_243;
ref_2_245=-ref_2_244;
ref_2_246=if_elseif(s0==1&s1==1,ref_2_245,s0==1&s1==2,ref_2_244,s0==2&s1==1,ref_2_245,s0==2&s1==2,ref_2_244);
G2(1,21)=ref_2_246*ref_0_2;
G2(2,21)=ref_2_246*ref_0_4;
G2(3,21)=ref_2_246*ref_0_10;
G2(4,21)=ref_2_246*ref_0_18;
ref_2_251=ref_2_246*ref_0_20;
ref_2_252=ref_1_121+ref_2_251;
G2(5,21)=ref_1_121+ref_2_252;
G2(6,21)=ref_2_246*ref_0_30;
G2(7,21)=ref_2_246*ref_0_31;
G2(8,21)=ref_2_246*ref_0_40;
G2(9,21)=ref_2_246*ref_0_46;
G2(10,21)=ref_2_246*ref_0_54;
G2(11,21)=ref_2_246*ref_0_60;
G2(4,22)=ref_1_121*y(11);
G2(10,22)=ref_1_121*y(2);
G2(4,23)=ref_1_121*y(10);
G2(5,23)=ref_1_121*ref_1_140;
G2(3,25)=ref_1_121*ref_1_142;
G2(4,26)=ref_1_121*ref_1_144;
G2(10,27)=ref_1_121*ref_1_147;
G2(11,27)=ref_1_121*ref_1_151;
G2(8,28)=ref_1_121*ref_1_153;
G2(6,29)=ref_1_121*ref_1_155;
G2(9,30)=ref_1_121*ref_1_157;
G2(3,31)=ref_1_121*ref_1_159;
G2(8,32)=ref_1_121*ref_1_161;
G2(6,33)=ref_1_121*ref_1_163;
G2(9,34)=ref_1_121*ref_1_165;
ref_2_276=2/y(11);
ref_2_277=ref_2_276*ref_1_138;
ref_2_278=ref_2_277*ref_1_137;
ref_2_279=-ref_2_278;
ref_2_280=ref_1_138^2;
ref_2_281=ref_2_279/ref_2_280;
ref_2_282=-ref_2_281;
G2(5,36)=ref_0_68*ref_2_282;
G2(1,14)=ref_1_121;
G2(1,16)=ref_1_121;
G2(1,23)=G2(4,16);
G2(2,5)=G1(4,6);
G2(2,23)=ref_1_121;
G2(3,6)=ref_1_121;
G2(4,8)=ref_0_68;
G2(4,24)=G2(4,16);
G2(4,35)=ref_0_68;
G2(6,22)=ref_1_121;
G2(7,11)=ref_1_121;
G2(7,26)=G2(4,26);
G2(8,16)=ref_1_121;
G2(9,24)=ref_1_121;
G2(10,7)=ref_0_68;
G2(11,20)=ref_1_121;
end;
if nargout>3;
G3=sparse(11,50653);
ref_3_284=-2/ref_1_81;
ref_3_285=ref_3_284*ref_1_81;
ref_3_286=ref_2_169*ref_2_168;
ref_3_287=ref_3_285+ref_3_286;
ref_3_288=ref_3_287*ref_1_80;
ref_3_289=-ref_3_288;
ref_3_291=2*ref_2_169;
ref_3_292=ref_3_291/ref_1_81;
ref_3_293=ref_3_292*ref_2_172;
ref_3_294=ref_2_172*ref_3_289;
ref_3_295=ref_3_293*ref_2_171;
ref_3_296=ref_3_294-ref_3_295;
ref_3_297=ref_2_172^2;
ref_3_298=ref_3_296/ref_3_297;
ref_3_299=-ref_3_298;
G3(11,1)=ref_0_68*ref_3_299;
ref_3_301=-ref_2_177;
ref_3_302=ref_3_301/ref_1_81;
ref_3_303=ref_3_302*ref_1_81;
ref_3_304=ref_2_179*ref_2_168;
ref_3_305=ref_3_303+ref_3_304;
ref_3_306=ref_3_305*ref_1_80;
ref_3_307=ref_2_169*ref_2_176;
ref_3_308=ref_3_306+ref_3_307;
ref_3_309=-ref_3_308;
ref_3_310=2*ref_2_179;
ref_3_311=ref_3_310/ref_1_81;
ref_3_312=ref_3_311*ref_2_172;
ref_3_313=ref_2_172*ref_3_309;
ref_3_314=ref_3_312*ref_2_171;
ref_3_315=ref_3_313-ref_3_314;
ref_3_316=ref_3_315/ref_3_297;
ref_3_317=-ref_3_316;
G3(11,2)=ref_0_68*ref_3_317;
G3(11,3)=ref_1_121*ref_2_174;
ref_3_320=ref_2_169*ref_2_187;
ref_3_321=-ref_3_320;
ref_3_322=ref_3_321/ref_2_172;
ref_3_323=-ref_3_322;
G3(11,4)=ref_0_68*ref_3_323;
ref_3_325=ref_2_179*ref_2_176;
ref_3_326=ref_2_177*ref_1_99;
ref_3_327=-ref_3_326;
ref_3_328=ref_3_327/ref_1_81;
ref_3_329=ref_3_328*ref_1_81;
ref_3_330=ref_2_179*ref_2_178;
ref_3_331=ref_3_329+ref_3_330;
ref_3_332=ref_3_331*ref_1_80;
ref_3_333=ref_3_332+ref_3_325;
ref_3_334=ref_3_325-ref_3_333;
ref_3_335=ref_3_334*ref_2_172;
ref_3_336=ref_3_312*ref_2_182;
ref_3_337=ref_3_335-ref_3_336;
ref_3_338=ref_3_337/ref_3_297;
ref_3_339=-ref_3_338;
G3(11,5)=ref_0_68*ref_3_339;
G3(11,6)=ref_1_121*ref_2_184;
ref_3_342=ref_2_179*ref_2_187;
ref_3_343=-ref_3_342;
ref_3_344=ref_3_343/ref_2_172;
ref_3_345=-ref_3_344;
G3(11,7)=ref_0_68*ref_3_345;
G3(11,8)=ref_2_246*ref_1_83;
G3(11,9)=ref_1_121*ref_2_189;
G3(2,11)=ref_2_246*ref_1_85;
G3(10,11)=ref_2_246*ref_1_87;
G3(4,14)=ref_2_246*y(8);
G3(5,14)=ref_2_246*ref_1_91;
G3(5,15)=ref_1_121*ref_2_196;
ref_3_355=ref_2_277/ref_2_280;
ref_3_356=-ref_3_355;
G3(5,16)=ref_0_68*ref_3_356;
G3(6,17)=ref_2_246*ref_1_93;
G3(8,17)=def(1)*ref_2_246;
ref_3_360=ref_1_102*ref_3_331;
ref_3_361=-ref_3_360;
ref_3_362=ref_2_172*ref_3_361;
ref_3_363=ref_3_312*ref_2_201;
ref_3_364=ref_3_362-ref_3_363;
ref_3_365=ref_3_364/ref_3_297;
ref_3_366=-ref_3_365;
G3(11,18)=ref_0_68*ref_3_366;
G3(11,19)=ref_1_121*ref_2_203;
ref_3_369=ref_2_179*ref_2_211;
ref_3_370=-ref_3_369;
ref_3_371=ref_3_370/ref_2_172;
ref_3_372=-ref_3_371;
G3(11,20)=ref_0_68*ref_3_372;
ref_3_374=ref_2_218*param(13);
ref_3_375=-ref_3_374;
ref_3_376=ref_3_375/ref_2_221;
G3(10,21)=ref_0_68*ref_3_376;
G3(10,22)=ref_1_121*ref_2_206;
G3(10,23)=ref_2_246*ref_1_97;
G3(11,23)=ref_2_246*ref_1_104;
G3(11,24)=ref_1_121*ref_2_213;
G3(4,25)=-ref_2_246;
ref_3_383=-2/ref_1_110;
ref_3_384=ref_3_383*ref_1_110;
ref_3_385=ref_2_218*ref_2_217;
ref_3_386=ref_3_384+ref_3_385;
ref_3_387=ref_0_49*ref_3_386;
ref_3_388=-ref_3_387;
ref_3_390=2*ref_2_218;
ref_3_391=ref_3_390/ref_1_110;
ref_3_392=ref_3_391*ref_2_221;
ref_3_393=ref_2_221*ref_3_388;
ref_3_394=ref_3_392*ref_2_220;
ref_3_395=ref_3_393-ref_3_394;
ref_3_396=ref_2_221^2;
ref_3_397=ref_3_395/ref_3_396;
G3(10,26)=ref_0_68*ref_3_397;
G3(10,27)=ref_1_121*ref_2_222;
ref_3_400=ref_1_146*ref_2_218;
ref_3_401=-ref_3_400;
ref_3_402=ref_3_401/ref_2_221;
G3(10,28)=ref_0_68*ref_3_402;
G3(2,29)=ref_2_246*ref_1_107;
G3(10,29)=ref_2_246*ref_1_111;
G3(10,30)=ref_1_121*ref_2_226;
G3(4,31)=ref_2_246*y(3);
ref_3_408=ref_2_229*param(6);
ref_3_409=ref_3_408*ref_0_64;
ref_3_410=ref_1_114*ref_2_229;
ref_3_411=ref_3_409+ref_3_410;
ref_3_412=ref_2_229*ref_1_114;
ref_3_413=ref_3_412+ref_3_412;
ref_3_414=ref_3_411+ref_3_413;
ref_3_415=ref_0_63*ref_3_408;
ref_3_416=ref_3_410+ref_3_415;
ref_3_417=ref_3_413+ref_3_416;
ref_3_418=ref_3_414-ref_3_417;
ref_3_419=ref_3_418*ref_1_118;
ref_3_420=ref_2_239*ref_2_235;
ref_3_421=ref_3_419+ref_3_420;
ref_3_422=2*ref_2_229;
ref_3_423=ref_3_422*ref_0_64;
ref_3_424=ref_1_114*ref_2_237;
ref_3_425=ref_3_423-ref_3_424;
ref_3_426=ref_3_425/ref_1_118;
ref_3_427=ref_3_426*ref_1_118;
ref_3_428=ref_2_239*ref_2_238;
ref_3_429=ref_3_427+ref_3_428;
ref_3_430=ref_1_117*ref_3_429;
ref_3_431=ref_2_235*ref_2_239;
ref_3_432=ref_3_430+ref_3_431;
ref_3_433=ref_3_421-ref_3_432;
ref_3_435=2*ref_2_239;
ref_3_436=ref_3_435/ref_1_118;
ref_3_437=ref_3_436*ref_2_243;
ref_3_438=ref_3_433*ref_2_243;
ref_3_439=ref_3_437*ref_2_242;
ref_3_440=ref_3_438-ref_3_439;
ref_3_441=ref_2_243^2;
ref_3_442=ref_3_440/ref_3_441;
ref_3_443=-ref_3_442;
ref_3_444=if_elseif(s0==1&s1==1,ref_3_443,s0==1&s1==2,ref_3_442,s0==2&s1==1,ref_3_443,s0==2&s1==2,ref_3_442);
G3(1,32)=ref_3_444*ref_0_2;
G3(2,32)=ref_3_444*ref_0_4;
G3(3,32)=ref_3_444*ref_0_10;
G3(4,32)=ref_3_444*ref_0_18;
ref_3_449=ref_3_444*ref_0_20;
ref_3_450=ref_2_246+ref_3_449;
ref_3_451=ref_2_246+ref_3_450;
G3(5,32)=ref_2_246+ref_3_451;
G3(6,32)=ref_3_444*ref_0_30;
G3(7,32)=ref_3_444*ref_0_31;
G3(8,32)=ref_3_444*ref_0_40;
G3(9,32)=ref_3_444*ref_0_46;
G3(10,32)=ref_3_444*ref_0_54;
G3(11,32)=ref_3_444*ref_0_60;
G3(4,33)=ref_2_246*y(11);
G3(10,33)=ref_2_246*y(2);
G3(4,34)=ref_2_246*y(10);
G3(5,34)=ref_2_246*ref_1_140;
G3(3,36)=ref_2_246*ref_1_142;
G3(4,37)=ref_2_246*ref_1_144;
G3(10,38)=ref_2_246*ref_1_147;
G3(11,38)=ref_2_246*ref_1_151;
G3(8,39)=ref_2_246*ref_1_153;
G3(6,40)=ref_2_246*ref_1_155;
G3(9,41)=ref_2_246*ref_1_157;
G3(3,42)=ref_2_246*ref_1_159;
G3(8,43)=ref_2_246*ref_1_161;
G3(6,44)=ref_2_246*ref_1_163;
G3(9,45)=ref_2_246*ref_1_165;
G3(5,47)=ref_1_121*ref_2_282;
ref_3_475=-2/ref_1_138;
ref_3_476=ref_3_475*ref_1_138;
ref_3_477=ref_2_277*ref_2_276;
ref_3_478=ref_3_476+ref_3_477;
ref_3_479=ref_3_478*ref_1_137;
ref_3_480=-ref_3_479;
ref_3_482=2*ref_2_277;
ref_3_483=ref_3_482/ref_1_138;
ref_3_484=ref_3_483*ref_2_280;
ref_3_485=ref_2_280*ref_3_480;
ref_3_486=ref_3_484*ref_2_279;
ref_3_487=ref_3_485-ref_3_486;
ref_3_488=ref_2_280^2;
ref_3_489=ref_3_487/ref_3_488;
ref_3_490=-ref_3_489;
G3(5,48)=ref_0_68*ref_3_490;
G3(1,23)=ref_2_246;
G3(1,25)=ref_2_246;
G3(1,34)=G3(4,25);
G3(2,10)=G2(4,16);
G3(2,34)=ref_2_246;
G3(3,11)=ref_2_246;
G3(4,13)=ref_1_121;
G3(4,35)=G3(4,25);
G3(4,46)=ref_1_121;
G3(6,33)=ref_2_246;
G3(7,17)=ref_2_246;
G3(7,37)=G3(4,37);
G3(8,25)=ref_2_246;
G3(9,35)=ref_2_246;
G3(10,12)=ref_1_121;
G3(11,31)=ref_2_246;
end;
