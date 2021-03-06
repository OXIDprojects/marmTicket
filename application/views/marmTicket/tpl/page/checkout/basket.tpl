[{capture append="oxidBlock_content"}]

    [{* ordering steps *}]

    [{block name="checkout_basket_main"}]
        [{assign var="currency" value=$oView->getActCurrency() }]
        [{if !$oxcmp_basket->getProductsCount()  }]
            [{block name="checkout_basket_emptyshippingcart"}]
                <div class="status corners error">[{ oxmultilang ident="PAGE_CHECKOUT_BASKET_EMPTYSHIPPINGCART" }]</div>
            [{/block}]
        [{else }]
            

            [{block name="basket_btn_next_bottom"}]
                [{if $oViewConf->getShowVouchers()}]
                        [{block name="checkout_basket_vouchers"}]
                            [{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
                            [{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
                            <div id="basketVoucher">
                                <form name="voucher" action="[{ $oViewConf->getSelfActionLink() }]" method="post" class="js-oxValidate">
                                    <div class="couponBox" id="coupon">
                                        [{foreach from=$Errors.basket item=oEr key=key}]
                                            [{if $oEr->getErrorClassType() == 'oxVoucherException'}]
                                                <div class="inlineError">
                                                    [{ oxmultilang ident="PAGE_CHECKOUT_BASKET_COUPONNOTACCEPTED1" }] <strong>&ldquo;[{ $oEr->getValue('voucherNr') }]&rdquo;</strong> [{ oxmultilang ident="PAGE_CHECKOUT_BASKET_COUPONNOTACCEPTED2" }]<br>
                                                    <strong>[{ oxmultilang ident="PAGE_CHECKOUT_BASKET_REASON" }]</strong>
                                                    [{ $oEr->getOxMessage() }]
                                                </div>
                                            [{/if}]
                                        [{/foreach}]
                                        <label>[{ oxmultilang ident="PAGE_CHECKOUT_BASKET_ENTERCOUPONNUMBER" }]</label>
                                        [{ $oViewConf->getHiddenSid() }]
                                        <input type="hidden" name="cl" value="basket">
                                        <input type="hidden" name="fnc" value="addVoucher">
                                        <input type="text" size="20" name="voucherNr" class="textbox js-oxValidate js-oxValidate_notEmpty">
                                        <button type="submit" class="submitButton">[{ oxmultilang ident="PAGE_CHECKOUT_BASKET_SUBMITCOUPON" }]</button>
                                        <p class="oxValidateError">
                                            <span class="js-oxError_notEmpty">[{ oxmultilang ident="EXCEPTION_INPUT_NOTALLFIELDS" }]</span>
                                        </p>
                                        <input type="hidden" name="CustomError" value='basket'>
                                    </div>
                                </form>
                                [{block name="checkout_basketcontents_voucherdiscount"}]
                                    [{if $oViewConf->getShowVouchers() && $oxcmp_basket->getVoucherDiscValue() }]
                                        [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=Voucher}]
                                           <div class="couponData">
                                                <strong>[{ oxmultilang ident="PAGE_CHECKOUT_BASKETCONTENTS_COUPON" }]:</strong>
                                                &nbsp;"[{ $sVoucher->sVoucherNr }]"&nbsp;
                                                <strong>(-[{ $sVoucher->fVoucherdiscount }]&nbsp;[{ $currency->sign }])</strong>
                                            </div>
                                        [{/foreach }]
                                    [{/if }]
                                [{/block}]
                            </div>
                        [{/block}]
                    [{/if}]
                    
                    
                    
                <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
                    [{include file="page/checkout/inc/visitordata.tpl" editable=true}]
                    [{ $oViewConf->getHiddenSid() }]
                    <input type="hidden" name="cl" value="user">
                    <input type="hidden" name="fnc" value="addVisitorData">
                    <button type="submit" class="submitButton largeButton nextStep">[{ oxmultilang ident="PAGE_CHECKOUT_BASKET_NEXTSTEP" }]</button>
                </form>
            [{/block}]
        [{/if }]
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]

[{include file="layout/page.tpl"}]