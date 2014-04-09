require 'net/http'
require 'open-uri'

module ApplicationHelper
    def pla_dynamic_site_menu(riding_id, language, customized_menus_en, customized_menus_fr, return_script=false)
        megamenu_return_str = nil

        if return_script
            megamenu_script_str = <<MEGAMENU_JAVASCRIPT
<script>
    var $ = jQuery.noConflict();
    jQuery(document).ready(function(){
    $('#mm_news').hide();
    $('#mm_photos').hide();
    $('#mm_donate').hide();

    $('#mm_navbullet_home').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_about_us').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_riding').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_news').mouseover(function(){
        $('#mm_news').show('5');
        //$('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_events').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_photos').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').show('5');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_issues').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_videos').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_volunteers').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').hide('2');
    });

    $('#mm_navbullet_donate').mouseover(function(){
        $('#mm_news').hide('2');
        $('#mm_photos').hide('2');
        $('#mm_donate').show('5');
    });

    $('#mm_navbullet_membership').mouseover(function(){
        $('#mm_news').hide('5');
        $('#mm_photos').hide('5');
        $('#mm_donate').hide('5');
    });

    $('#mm_navbullet_contacts').mouseover(function(){
        $('#mm_news').hide('5');
        $('#mm_photos').hide('5');
        $('#mm_donate').hide('5');
    });

    $('#mm_navbullet_enewsletter').mouseover(function(){
        $('#mm_news').hide('5');
        $('#mm_photos').hide('5');
        $('#mm_donate').hide('5');
    });

        $('#mm_news').bind('mouseleave', hide_mm_news);
        $('#mm_photos').bind('mouseleave', hide_mm_photos);
        $('#mm_donate').bind('mouseleave', hide_mm_donate);

    });

    function hide_mm_news(){$('#mm_news').hide('2');}
    function hide_mm_photos(){$('#mm_photos').hide('2');}
    function hide_mm_donate(){$('#mm_donate').hide('2');}
</script>
MEGAMENU_JAVASCRIPT
            megamenu_return_str = megamenu_script_str
        else

            megamenu_str = nil

            # English Main Menu
            megamenu_home_en      = ''
            if customized_menu_item('Home', customized_menus_en) != nil && customized_menu_item('Home', customized_menus_en) != ''
                megamenu_home_en      = '<li id="mm_navbullet_home"><a href="/Home">' + customized_menu_item('Home', customized_menus_en) + '</a></li>'
            end            
            megamenu_about_us_en = ''
            if customized_menu_item('Leader', customized_menus_en) != nil && customized_menu_item('Leader', customized_menus_en) != ''
                megamenu_about_us_en = '<li id="mm_navbullet_about_us"><a href="/Leader">' + customized_menu_item('Leader', customized_menus_en) + '</a></li>'
            end
            megamenu_riding_en = ''
            if customized_menu_item('Team', customized_menus_en) != nil && customized_menu_item('Team', customized_menus_en) != ''
                megamenu_riding_en = '<li id="mm_navbullet_riding"><a href="/Team">' + customized_menu_item('Team', customized_menus_en) + '</a></li>'
            end
            megamenu_news_en      = ''
            if customized_menu_item('News', customized_menus_en) != nil && customized_menu_item('News', customized_menus_en) != ''
                megamenu_news_en      = '<li id="mm_navbullet_news"><a href="/News">' + customized_menu_item('News', customized_menus_en) + '</a></li>'
            end
            megamenu_events_en    = ''
            if customized_menu_item('Events', customized_menus_en) != nil && customized_menu_item('Events', customized_menus_en) != ''
                megamenu_events_en    = '<li id="mm_navbullet_events"><a href="/Event">' + customized_menu_item('Events', customized_menus_en) + '</a></li>'
            end
            megamenu_photos_en    = ''
            if customized_menu_item('Photos', customized_menus_en) != nil && customized_menu_item('Photos', customized_menus_en) != ''
                megamenu_photos_en    = '<li id="mm_navbullet_photos"><a href="/Photo">' + customized_menu_item('Photos', customized_menus_en) + '</a></li>'
            end
            megamenu_issues_en    = ''
            if customized_menu_item('Issues', customized_menus_en) != nil && customized_menu_item('Issues', customized_menus_en) != ''
                megamenu_issues_en    = '<li id="mm_navbullet_issues"><a href="/pIssue">' + customized_menu_item('Issues', customized_menus_en) + '</a></li>'
            end
            megamenu_videos_en    = ''
            if customized_menu_item('Video', customized_menus_en) != nil && customized_menu_item('Video', customized_menus_en) != ''
                megamenu_videos_en    = '<li id="mm_navbullet_videos"><a href="/Video">' + customized_menu_item('Video', customized_menus_en) + '</a></li>'
            end
            megamenu_volunteer_en = ''
            if customized_menu_item('Platform', customized_menus_en) != nil && customized_menu_item('Platform', customized_menus_en) != ''
                megamenu_volunteer_en = '<li id="mm_navbullet_volunteers"><a href="/Platform">' + customized_menu_item('Platform', customized_menus_en) + '</a></li>'
            end
            megamenu_donate_en    = ''
            if customized_menu_item('Donate', customized_menus_en) != nil && customized_menu_item('Donate', customized_menus_en) != ''
                megamenu_donate_en    = '<li id="mm_navbullet_donate"><a href="https://contribute.ontarioliberal.ca/Home/Donate?origin=PLA&SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Donate', customized_menus_en) + '</a></li>'
            end
            megamenu_membership_en    = ''
            if customized_menu_item('Membership', customized_menus_en) != nil && customized_menu_item('Membership', customized_menus_en) != ''
                megamenu_membership_en    = '<li id="mm_navbullet_membership"><a href="https://contribute.ontarioliberal.ca/Home/Join?SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Membership', customized_menus_en) + '</a></li>'
            end
            megamenu_contact_en   = ''
            if customized_menu_item('Contact', customized_menus_en) != nil && customized_menu_item('Contact', customized_menus_en) != ''
                megamenu_contact_en   = '<li id="mm_navbullet_contacts"><a href="/pContact">' + customized_menu_item('Contact', customized_menus_en) + '</a></li>'
            end
            megamenu_enewsletter_en   = ''
            if customized_menu_item('Enewsletter', customized_menus_en) != nil && customized_menu_item('Enewsletter', customized_menus_en) != ''
                megamenu_enewsletter_en   = '<li id="mm_navbullet_enewsletter"><a href="/Enewsletter">' + customized_menu_item('Enewsletter', customized_menus_en) + '</a></li>'
            end
            megamenu_special_en   = ''
            if customized_menu_item('Special', customized_menus_en, false) != nil && customized_menu_item('Special', customized_menus_en, false) != ''
                megamenu_special_en   = '<li id="mm_navbullet_contacts"><a href="/pSpecial">' + customized_menu_item('Special', customized_menus_en, false) + '</a></li>'
            end
            # English Secondary Menu
            megasubmenu_donate_en    = ''
            if customized_menu_item('Donate', customized_menus_en) != nil && customized_menu_item('Donate', customized_menus_en) != ''
                megasubmenu_donate_en    = '<li><a href="https://contribute.ontarioliberal.ca/Home/Donate?origin=PLA&SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Donate', customized_menus_en) + '</a></li>'
            end
            megasubmenu_blog_en           = ''
            if customized_menu_item('Blog', customized_menus_en) != nil && customized_menu_item('Blog', customized_menus_en) != ''
                megasubmenu_blog_en           = '<li><a href="/pBlog">' + customized_menu_item('Blog', customized_menus_en) + '</a></li>'
            end
            megasubmenu_endorsements_en    = ''
            if customized_menu_item('Endorsements', customized_menus_en) != nil && customized_menu_item('Endorsements', customized_menus_en) != ''
                megasubmenu_endorsements_en    = '<li><a href="/pEndorsement">' + customized_menu_item('Endorsements', customized_menus_en) + '</a></li>'
            end
            megasubmenu_enewsletter_en    = ''
            if customized_menu_item('Enewsletter', customized_menus_en) != nil && customized_menu_item('Enewsletter', customized_menus_en) != ''
                megasubmenu_enewsletter_en    = '<li><a href="/Enewsletter">' + customized_menu_item('Enewsletter', customized_menus_en) + '</a></li>'
            end
            megasubmenu_membership_en     = ''
            if customized_menu_item('Membership', customized_menus_en) != nil && customized_menu_item('Membership', customized_menus_en) != ''
                megasubmenu_membership_en     = '<li><a href="https://contribute.ontarioliberal.ca/Home/Join?SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Membership', customized_menus_en) + '</a></li>'
            end
            megasubmenu_accessibility_en  = ''
            if customized_menu_item('Accessibility', customized_menus_en) != nil && customized_menu_item('Accessibility', customized_menus_en) != ''
                megasubmenu_accessibility_en  = '<li><a href="/pAccessibility">' + customized_menu_item('Accessibility', customized_menus_en) + '</a></li>'
            end
            megasubmenu_progress_en       = ''
            if customized_menu_item('Progress', customized_menus_en) != nil && customized_menu_item('Progress', customized_menus_en) != ''
                megasubmenu_progress_en       = '<li><a href="/pProgress">' + customized_menu_item('Progress', customized_menus_en) + '</a></li>'
            end
            megasubmenu_ontarioliberal_en = ''
            if customized_menu_item('Ontario Liberal', customized_menus_en) != nil && customized_menu_item('Ontario Liberal', customized_menus_en) != ''
                megasubmenu_ontarioliberal_en = '<li><a href="http://www.ontarioliberal.ca" target="_blank">' + customized_menu_item('Ontario Liberal', customized_menus_en) + '</a></li>'
            end

            # French Main Menu
            megamenu_home_fr      = ''
            if customized_menu_item('Accueil', customized_menus_fr) != nil && customized_menu_item('Accueil', customized_menus_fr) != ''
                megamenu_home_fr      = '<li id="mm_navbullet_home"><a href="/Home?l=fr">' + customized_menu_item('Accueil', customized_menus_fr) + '</a></li>'
            end
            megamenu_about_us_fr = ''
            if customized_menu_item('Leader', customized_menus_fr) != nil && customized_menu_item('Leader', customized_menus_fr) != ''
                megamenu_about_us_fr = '<li id="mm_navbullet_about_us"><a href="/Leader?l=fr">' + customized_menu_item('&Agrave; notre sujet', customized_menus_fr) + '</a></li>'
            end
            megamenu_riding_fr = ''
            if customized_menu_item('Team', customized_menus_fr) != nil && customized_menu_item('Team', customized_menus_fr) != ''
                megamenu_riding_fr = '<li id="mm_navbullet_riding"><a href="/Team?l=fr">' + customized_menu_item('&Agrave; notre riding', customized_menus_fr) + '</a></li>'
            end
            megamenu_news_fr      = ''
            if customized_menu_item('Nouvelles', customized_menus_fr) != nil && customized_menu_item('Nouvelles', customized_menus_fr) != ''
                megamenu_news_fr      = '<li id="mm_navbullet_news"><a href="/News?l=fr">' + customized_menu_item('Nouvelles', customized_menus_fr) + '</a></li>'
            end
            megamenu_events_fr    = ''
            if customized_menu_item('&#201;v&#233;nements', customized_menus_fr) != nil && customized_menu_item('&#201;v&#233;nements', customized_menus_fr) != ''
                megamenu_events_fr    = '<li id="mm_navbullet_events"><a href="/Event?l=fr">' + customized_menu_item('&#201;v&#233;nements', customized_menus_fr) + '</a></li>'
            end
            megamenu_photos_fr    = ''
            if customized_menu_item('Photos', customized_menus_fr) != nil && customized_menu_item('Photos', customized_menus_fr) != ''
                megamenu_photos_fr    = '<li id="mm_navbullet_photos"><a href="/Photo?l=fr">' + customized_menu_item('Photos', customized_menus_fr) + '</a></li>'
            end
            megamenu_issues_fr    = ''
            if customized_menu_item('Enjeux', customized_menus_fr) != nil && customized_menu_item('Enjeux', customized_menus_fr) != ''
                megamenu_issues_fr    = '<li id="mm_navbullet_issues"><a href="/pIssue?l=fr">' + customized_menu_item('Enjeux', customized_menus_fr) + '</a></li>'
            end
            megamenu_videos_fr    = ''
            if customized_menu_item('Vid&#233;os', customized_menus_fr) != nil && customized_menu_item('Vid&#233;os', customized_menus_fr) != ''
                megamenu_videos_fr    = '<li id="mm_navbullet_videos"><a href="/Video?l=fr">' + customized_menu_item('Vid&#233;os', customized_menus_fr) + '</a></li>'
            end
            megamenu_volunteer_fr = ''
            if customized_menu_item('B&#233;n&#233;volat', customized_menus_fr) != nil && customized_menu_item('B&#233;n&#233;volat', customized_menus_fr) != ''
                megamenu_volunteer_fr = '<li id="mm_navbullet_volunteers"><a href="/Platform?l=fr">' + customized_menu_item('B&#233;n&#233;volat', customized_menus_fr) + '</a></li>'
            end
            megamenu_donate_fr    = ''
            if customized_menu_item('Faites un don', customized_menus_fr) != nil && customized_menu_item('Faites un don', customized_menus_fr) != ''
                megamenu_donate_fr    = '<li id="mm_navbullet_donate"><a href="https://contribute.ontarioliberal.ca/Home/contribuer?origin=PLA&SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Faites un don', customized_menus_fr) + '</a></li>'
            end
            megamenu_membership_fr    = ''
            if customized_menu_item('Adh&#233;sion', customized_menus_en) != nil && customized_menu_item('Adh&#233;sion', customized_menus_en) != ''
                megamenu_membership_fr    = '<li id="mm_navbullet_membership"><a href="https://contribute.ontarioliberal.ca/Home/devenir_membre?SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Adh&#233;sion', customized_menus_en) + '</a></li>'
            end
            megamenu_contact_fr   = ''
            if customized_menu_item('Nous joindre', customized_menus_fr) != nil && customized_menu_item('Nous joindre', customized_menus_fr) != ''
                megamenu_contact_fr   = '<li id="mm_navbullet_contacts"><a href="/pContact?l=fr">' + customized_menu_item('Nous joindre', customized_menus_fr) + '</a></li>'
            end
            megamenu_enewsletter_fr   = ''
            if customized_menu_item('Enewsletter', customized_menus_fr) != nil && customized_menu_item('Enewsletter', customized_menus_fr) != ''
                megamenu_enewsletter_fr   = '<li id="mm_navbullet_enewsletter"><a href="/Enewsletter?l=fr">' + customized_menu_item('Enewsletter', customized_menus_fr) + '</a></li>'
            end
            megamenu_special_fr   = ''
            if customized_menu_item('Sp&#233;cial', customized_menus_fr, false) != nil && customized_menu_item('Sp&#233;cial', customized_menus_fr, false) != ''
                megamenu_special_fr   = '<li id="mm_navbullet_contacts"><a href="/pSpecial?l=fr">' + customized_menu_item('Sp&#233;cial', customized_menus_fr, false) + '</a></li>'
            end
            # French Secondary Menu
            megasubmenu_donate_fr    = ''
            if customized_menu_item('Faites un don', customized_menus_fr) != nil && customized_menu_item('Faites un don', customized_menus_fr) != ''
                megasubmenu_donate_fr    = '<li><a href="https://contribute.ontarioliberal.ca/Home/contribuer?origin=PLA&SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Faites un don', customized_menus_fr) + '</a></li>'
            end
            megasubmenu_blog_fr           = ''
            if customized_menu_item('Blogue', customized_menus_fr) != nil && customized_menu_item('Blogue', customized_menus_fr) != ''
                megasubmenu_blog_fr           = '<li><a href="/pBlog?l=fr">' + customized_menu_item('Blogue', customized_menus_fr) + '</a></li>'
            end
            megasubmenu_endorsements_fr    = ''
            if customized_menu_item('Approbation', customized_menus_fr) != nil && customized_menu_item('Approbation', customized_menus_fr) != ''
                megasubmenu_endorsements_fr    = '<li><a href="/pEndorsement?l=fr">' + customized_menu_item('Approbation', customized_menus_fr) + '</a></li>'
            end
            megasubmenu_enewsletter_fr    = ''
            if customized_menu_item('Cyberlettre', customized_menus_fr) != nil && customized_menu_item('Cyberlettre', customized_menus_fr) != ''
                megasubmenu_enewsletter_fr    = '<li><a href="/Enewsletter?l=fr">' + customized_menu_item('Cyberlettre', customized_menus_fr) + '</a></li>'
            end
            megasubmenu_membership_fr     = ''
            if customized_menu_item('Adh&#233;sion', customized_menus_fr) != nil && customized_menu_item('Adh&#233;sion', customized_menus_fr) != ''
                megasubmenu_membership_fr     = '<li><a href="https://contribute.ontarioliberal.ca/Home/devenir_membre?SS=1&EDID=' + (riding_id+9000).to_s + '" target="_blank">' + customized_menu_item('Adh&#233;sion', customized_menus_fr) + '</a></li>'
            end
            megasubmenu_accessibility_fr  = ''
            if customized_menu_item('Accommodement', customized_menus_fr) != nil && customized_menu_item('Accommodement', customized_menus_fr) != ''
                megasubmenu_accessibility_fr  = '<li><a href="/pAccessibility?l=fr">' + customized_menu_item('Accommodement', customized_menus_fr) + '</a></li>'
            end
            megasubmenu_progress_fr       = ''
            if customized_menu_item('Progr&#232;s', customized_menus_fr) != nil && customized_menu_item('Progr&#232;s', customized_menus_fr) != ''
                megasubmenu_progress_fr       = '<li><a href="/pProgress?l=fr">' + customized_menu_item('Progr&#232;s', customized_menus_fr) + '</a></li>'
            end
            megasubmenu_ontarioliberal_fr = ''
            if customized_menu_item('Parti Lib&#233;ral de l\'Ontario', customized_menus_fr) != nil && customized_menu_item('Parti Lib&#233;ral de l\'Ontario', customized_menus_fr) != ''
                megasubmenu_ontarioliberal_fr = '<li><a href="http://www.ontarioliberal.ca" target="_blank">' + customized_menu_item('Parti Lib&#233;ral de l\'Ontario', customized_menus_fr) + '</a></li>'
            end


            riding_news_documents = PlaDocument.find(:all, :order => "document_date DESC", :conditions => {:riding_id => riding_id, :doc_type => (0..1), :published => true, :language => language, :expiry_date => DateTime.now..(DateTime.now+3650)})
            central_news_documents = Document.find(:all, :order => "document_date DESC", :conditions => {:riding_id => 0, :doc_type => (0..1), :published => true, :publish_on_pla => true, :language => language, :expiry_date => DateTime.now..(DateTime.now+3650)})
            customized_managements = PlaCustomizedManagement.find(:all, :order => "id", :conditions => {:riding_id => riding_id, :central_table => "documents"})
            if customized_managements != nil && customized_managements.length > 0 && central_news_documents != nil && central_news_documents.length > 0
                customized_managements.each do |customized_management|
                    central_news_documents.each do |news_document|
                        if news_document.id == customized_management.central_record_id
                            news_document.headline = customized_management.local_headline_en
                            news_document.published = customized_management.is_local_published
                            if news_document.published == false
                                central_news_documents.delete(news_document)
                            end
                        end
                    end
                end
            end
            top_news_documents = Array.new
            while (riding_news_documents != nil && riding_news_documents.length > 0) || (central_news_documents != nil && central_news_documents.length > 0)
                if riding_news_documents == nil || riding_news_documents.length <= 0
                    central_news_documents[0].is_draft = false
                    top_news_documents << central_news_documents[0]
                    central_news_documents.delete_at(0)
                elsif central_news_documents == nil || central_news_documents.length <= 0
                    riding_news_documents[0].is_draft = true
                    top_news_documents << riding_news_documents[0]
                    riding_news_documents.delete_at(0)
                elsif central_news_documents[0].document_date < riding_news_documents[0].document_date
                    riding_news_documents[0].is_draft = true
                    top_news_documents << riding_news_documents[0]
                    riding_news_documents.delete_at(0)
                else
                    central_news_documents[0].is_draft = false
                    top_news_documents << central_news_documents[0]
                    central_news_documents.delete_at(0)
                end
            end

            customized_categories = CustomizedCategory.find(:all, :order => "caption_en", :conditions => {:riding_id => riding_id, :published => true, :db_name => 'r'})

            megamenu_news_popup_en = %Q[
                <div id="mm_news" class="popundernavigation">
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h2>Recently added</h2>
            ]
            if top_news_documents[0] != nil then megamenu_news_popup_en += '<h3><a href="' + (top_news_documents[0].is_draft ? '/News/' : '/News/') + top_news_documents[0].id.to_s + '">' + top_news_documents[0].headline + '</a></h3>' end
            if top_news_documents[1] != nil then megamenu_news_popup_en += '<h3><a href="' + (top_news_documents[1].is_draft ? '/News/' : '/News/') + top_news_documents[1].id.to_s + '">' + top_news_documents[1].headline + '</a></h3>' end
            if top_news_documents[2] != nil then megamenu_news_popup_en += '<h3><a href="' + (top_news_documents[2].is_draft ? '/News/' : '/News/') + top_news_documents[2].id.to_s + '">' + top_news_documents[2].headline + '</a></h3>' end
            if customized_categories != nil && customized_categories.length > 0
                # remove these 2 categories from list
                #            <p><a href="/News?pc=0">Generic</a></p>
                #            <p><a href="/News?pc=13">Condolences</a></p>
                megamenu_news_popup_en += %Q[
                            <br />
                            <h2><a href="/News">All News</a></h2>
                        </div>
                        <div class="mmcol" style="float:left; width:260px; padding:20px;">
                            <h1>Popular Topics</h1>
                            <!-- <p><a href="/News?pc=12">Agriculture</a></p> -->
                            <!-- <p><a href="/News?pc=4">Crime and Community Safety</a></p> -->
                            <p><a href="/News?pc=3">Economy and Jobs</a></p>
                            <p><a href="/News?pc=5">Education</a></p>
                            <p><a href="/News?pc=1">Environment</a></p>
                            <!-- <p><a href="/News?pc=11">Government Efficiency</a></p> -->
                            <!-- <p><a href="/News?pc=8">Green Energy</a></p> -->
                            <p><a href="/News?pc=6">Healthcare</a></p>
                            <!-- <p><a href="/News?pc=10">Immigration Services</a></p> -->
                            <!-- <p><a href="/News?pc=7">Infrastructure</a></p> -->
                            <!-- <p><a href="/News?pc=2">Job/Wages</a></p> -->
                            <!-- <p><a href="/News?pc=9">Tax Reform</a></p> -->
                            <!-- <p><a href="/News?pc=14">Transit</a></p> -->
                        </div>
                        <div class="mmcol" style="float:left; width:260px; padding:20px;">
                            <h1>Trending Topics</h1>
                ]
                customized_categories.each do |customized_category|
                    megamenu_news_popup_en += '<p><a href="/News?cc=' + customized_category.id.to_s + '">' + customized_category.caption_en + '</a></p>'
                end
                megamenu_news_popup_en += %Q[
                        </div>
                    </div>
                ]
            else
                # remove these 2 categories from list
                #            <p><a href="/News?pc=0">Generic</a></p>
                #            <p><a href="/News?pc=13">Condolences</a></p>
                megamenu_news_popup_en += %Q[
                            <br />
                            <h2><a href="/News">All News</a></h2>
                        </div>
                        <div class="mmcol" style="float:left; width:260px; padding:20px;">
                            <h1>Popular Topics</h1>
                            <!-- <p><a href="/News?pc=12">Agriculture</a></p> -->
                            <!-- <p><a href="/News?pc=4">Crime and Community Safety</a></p> -->
                            <p><a href="/News?pc=3">Economy and Jobs</a></p>
                            <p><a href="/News?pc=1">Environment</a></p>
                            <!-- <p><a href="/News?pc=11">Government Efficiency</a></p> -->
                            <p><a href="/News?pc=5">Education</a></p>
                            <!-- <p><a href="/News?pc=8">Green Energy</a></p> -->
                            <p><a href="/News?pc=6">Healthcare</a></p>
                            <!-- <p><a href="/News?pc=10">Immigration Services</a></p> -->
                            <!-- <p><a href="/News?pc=7">Infrastructure</a></p> -->
                            <!-- <p><a href="/News?pc=2">Job/Wages</a></p> -->
                            <!-- <p><a href="/News?pc=9">Tax Reform</a></p> -->
                            <!-- <p><a href="/News?pc=14">Transit</a></p> -->
                        </div>
                    </div>
                ]
            end

            megamenu_news_popup_fr = %Q[
                <div id="mm_news" class="popundernavigation">
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h2><a href="news">Ajout&eacute; r&eacute;cemment</a></h2>
            ]
            if top_news_documents[0] != nil then megamenu_news_popup_fr += '<h3><a href="' + (top_news_documents[0].is_draft ? '/News/' : '/News/') + top_news_documents[0].id.to_s + '">' + top_news_documents[0].headline + '</a></h3>' end
            if top_news_documents[1] != nil then megamenu_news_popup_fr += '<h3><a href="' + (top_news_documents[1].is_draft ? '/News/' : '/News/') + top_news_documents[1].id.to_s + '">' + top_news_documents[1].headline + '</a></h3>' end
            if top_news_documents[2] != nil then megamenu_news_popup_fr += '<h3><a href="' + (top_news_documents[2].is_draft ? '/News/' : '/News/') + top_news_documents[2].id.to_s + '">' + top_news_documents[2].headline + '</a></h3>' end
            if customized_categories != nil && customized_categories.length > 0
                # remove these 2 categories from list
                #            <p><a href="/News?pc=0">Generic</a></p>
                #            <p><a href="/News?pc=13">Condolences</a></p>
                megamenu_news_popup_fr += %Q[
                            <br />
                            <h2><a href="news">All News</a></h2>
                        </div>
                        <div class="mmcol" style="float:left; width:260px; padding:20px;">
                            <h1>Popular Topics</h1>
                            <!-- <p><a href="/News?pc=12">Agriculture</a></p> -->
                            <!-- <p><a href="/News?pc=4">Crime and Community Safety</a></p> -->
                            <p><a href="/News?pc=3">Economy</a></p>
                            <p><a href="/News?pc=5">Education</a></p>
                            <p><a href="/News?pc=1">Environment</a></p>
                            <!-- <p><a href="/News?pc=11">Government Efficiency</a></p> -->
                            <!-- <p><a href="/News?pc=8">Green Energy</a></p> -->
                            <p><a href="/News?pc=6">Healthcare</a></p>
                            <!-- <p><a href="/News?pc=10">Immigration Services</a></p> -->
                            <!-- <p><a href="/News?pc=7">Infrastructure</a></p> -->
                            <!-- <p><a href="/News?pc=2">Job/Wages</a></p> -->
                            <!-- <p><a href="/News?pc=9">Tax Reform</a></p> -->
                            <!-- <p><a href="/News?pc=14">Transit</a></p> -->
                        </div>
                        <div class="mmcol" style="float:left; width:260px; padding:20px;">
                            <h1>Trending Topics</h1>
                ]
                customized_categories.each do |customized_category|
                    megamenu_news_popup_fr += '<p><a href="/News?cc=' + customized_category.id.to_s + '&l=fr">' + customized_category.caption_fr + '</a></p>'
                end
                megamenu_news_popup_fr += %Q[
                        </div>
                    </div>
                ]
            else
                # remove these 2 categories from list
                #            <p><a href="/News?pc=0">Generic</a></p>
                #            <p><a href="/News?pc=13">Condolences</a></p>
                megamenu_news_popup_fr += %Q[
                            <br />
                            <h2><a href="news">All News</a></h2>
                        </div>
                        <div class="mmcol" style="float:left; width:260px; padding:20px;">
                            <h1>Popular Topics</h1>
                            <!-- <p><a href="/News?pc=12">Agriculture</a></p> -->
                            <!-- <p><a href="/News?pc=4">Crime and Community Safety</a></p> -->
                            <p><a href="/News?pc=3">Economy</a></p>
                            <p><a href="/News?pc=5">Education</a></p>
                            <!-- <p><a href="/News?pc=11">Government Efficiency</a></p> -->
                        </div>
                        <div class="mmcol" style="float:left; width:260px; padding:20px;">
                            <p><a href="/News?pc=1">Environment</a></p>
                            <!-- <p><a href="/News?pc=8">Green Energy</a></p> -->
                            <p><a href="/News?pc=6">Healthcare</a></p>
                            <!-- <p><a href="/News?pc=10">Immigration Services</a></p> -->
                            <!-- <p><a href="/News?pc=7">Infrastructure</a></p> -->
                            <!-- <p><a href="/News?pc=2">Job/Wages</a></p> -->
                            <!-- <p><a href="/News?pc=9">Tax Reform</a></p> -->
                            <!-- <p><a href="/News?pc=14">Transit</a></p> -->
                        </div>
                    </div>
                ]
            end

            megamenu_photos_popup_en = ''
            megamenu_photos_popup_fr = ''
            photos = Photo.find(:all, :limit => 1, :order => "created_date DESC", :conditions => {:riding_id => riding_id, :published => true})
            if photos != nil && photos.length > 0
                local_photo_galleries = PlaPhotoAlbum.find(:all, :order => "description_en", :conditions => {:riding_id => riding_id, :published => true})
                if local_photo_galleries != nil && local_photo_galleries.length > 0
                    olp_photos = Photo.find(:all, :limit => 1, :order => "created_date DESC", :conditions => {:riding_id => 0, :published => true, :album_id => (0..999)})
                    megamenu_photos_popup_en = %Q[
                        <div id="mm_photos" class="popundernavigation">
                            <div class="mmcol" style="float:left; width:260px; padding:20px;">
                                <h1><a href="/Photo" target="_self">Photo of the Day</a></h1>
                                <div id="megathumbdiv" style="margin-bottom:-16px;"><a href="/Photo" target="_self"><img border="0" src="http://pantone201.ca/webskins/pla/photos/#{photos[0].id.to_s}_#{photos[0].riding_id.to_s}#{photos[0].filename.to_s}_PhotoUp.jpg" width="240" height="150" /></a></div>
                                <p style="clear:both; display:block;">#{photos[0].caption_en}</p>
                            </div>
                            <div class="mmcol" style="float:left; width:260px; padding:20px;">
                                <h1 style="padding-bottom:10px;">Available Galleries</h1>
                    ]
                    megamenu_photos_popup_fr = %Q[
                        <div id="mm_photos" class="popundernavigation">
                            <div class="mmcol" style="float:left; width:260px; padding:20px;">
                                <h1><a href="/Photo?l=fr" target="_self">Photo du jour</a></h1>
                                <div id="megathumbdiv" style="margin-bottom:-16px;"><a href="/Photo?l=fr" target="_self"><img border="0" src="http://pantone201.ca/webskins/pla/photos/#{photos[0].id.to_s}_#{photos[0].riding_id.to_s}#{photos[0].filename.to_s}_PhotoUp.jpg" width="240" height="150" /></a></div>
                                <p style="clear:both; display:block;">#{photos[0].caption_fr}</p>
                            </div>
                            <div class="mmcol" style="float:left; width:260px; padding:20px;">
                                <h1 style="padding-bottom:10px;">Albums-photos</h1>
                    ]
                    local_photo_galleries.each do |local_photo_gallery|
                        megamenu_photos_popup_en += "<p><a href=\"/Photo?pg=" + local_photo_gallery.id.to_s + "\">" + local_photo_gallery.description_en + "</a></p>"
                        megamenu_photos_popup_fr += "<p><a href=\"/Photo?l=fr&pg=" + local_photo_gallery.id.to_s + "\">" + local_photo_gallery.description_fr + "</a></p>"
                    end
                    megamenu_photos_popup_en += %Q[
                                <p><a href="/Photo">View all ...</a></p>
                            </div>
                            <div class="mmcol" style="float:left; width:260px; padding:20px;">
                                <h1><a href="/Photo" target="_self">Photo of the Day from Ontario Liberal</a></h1>
                                <div id="megathumbdiv" style="margin-bottom:-16px;"><a href="/Photo" target="_self"><img border="0" src="http://pantone201.ca/webskins/olp/photos/#{olp_photos[0].id.to_s}_#{olp_photos[0].riding_id.to_s}#{olp_photos[0].filename.to_s}_PhotoUp.jpg" width="180" height="110" /></a></div>
                                <p class="caption">#{olp_photos[0].caption_en}</p>
                            </div>
                        </div>
                    ]
                    megamenu_photos_popup_fr += %Q[
                                <p><a href="/Photo?l=fr">View all ...</a></p>
                            </div>
                            <div class="mmcol" style="float:left; width:260px; padding:20px;">
                                <h1><a href="/Photo?l=fr" target="_self">Photo du jour au Parti lib&eacute;ral de l'Ontario</a></h1>
                                <div id="megathumbdiv" style="margin-bottom:-16px;"><a href="/Photo?l=fr" target="_self"><img border="0" src="http://pantone201.ca/webskins/olp/photos/#{olp_photos[0].id.to_s}_#{olp_photos[0].riding_id.to_s}#{olp_photos[0].filename.to_s}_PhotoUp.jpg" width="180" height="110" /></a></div>
                                <p class="caption">#{olp_photos[0].caption_fr}</p>
                            </div>
                        </div>
                    ]
                end
            else
                megamenu_photos_en = ''
                megamenu_photos_fr = ''
            end

            megamenu_donate_popup_en = %Q[
                <div id="mm_donate" class="popundernavigation">
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h1><a href="https://contribute.ontarioliberal.ca/Home/Donate?origin=PLA&SS=1&EDID=#{(riding_id+9000).to_s}" target="_blank">Donate Now</a></h1>
                        <p>Your donation will make a real difference!</p>
                        <a href="https://contribute.ontarioliberal.ca/Home/Donate?origin=PLA&SS=1&EDID=#{(riding_id+9000).to_s}" target="_blank"><img src="http://pantone201.ca/webskins/pla/css/img/donationimage.png" border="0" width="260" /></a>

                    </div>
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h1><a href="https://contribute.ontarioliberal.ca/home/abc?edid=#{(riding_id+9000).to_s}&origin=PLA" target="_self">Make a Monthly Contribution (ABC)</a></h1>
                        <p>By joining the Ontario Liberal Party&#039;s <a href="/pAbcMember" target="_self">ABC Plan</a>, your membership will be renewed automatically. <a href="/pAbcMember" target="_self">[Read more]</a></p>
                        <br/>
                        <h1><a href="/pAboutDonations" target="_self">About Donations</a></h1>
                        <p>Thanks to your hard work, and the hard work of all Ontarians, Ontario is back on track.
                        <a href="/pAboutDonations">See how your donations make a difference ...</a></p>
                    </div>
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h1><a href="/pTaxableBenefits" target="_self">Taxable Benefits</a></h1>
                        <p>Making a difference costs less than you might think; if you gave $300.00 you'd get back $225.00 at tax time.
                        <a href="/pTaxableBenefits">Read more about taxable benefits, donation limits and eligibility criteria...</a></p>
                    </div>
                </div>
            ]

            megamenu_donate_popup_fr = %Q[
                <div id="mm_donate" class="popundernavigation">
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h1><a href="https://contribute.ontarioliberal.ca/Home/contribuer?SS=1&EDID=#{(riding_id+9000).to_s}" target="_blank">Faites un don</a></h1>
                        <p>Votre don nous aide &agrave; avancer!</p>
                        <a href="https://contribute.ontarioliberal.ca/Home/contribuer?SS=1&EDID=#{(riding_id+9000).to_s}" target="_blank"><img src="http://pantone201.ca/webskins/pla/css/img/donationimage.png" border="0" width="260" /></a>

                    </div>
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h1><a href="https://contribute.ontarioliberal.ca/home/abc?edid=#{(riding_id+9000).to_s}&origin=PLA" target="_self">Faites une contribution mensuelle (ABC)</a></h1>
                        <p>Lorsque vous joignez <a href="/pAbcMember?l=fr" target="_self">le Plan ABC</a> du Parti lib&eacute;ral de l&#039;Ontario, votre adh&eacute;sion sera renouvel&eacute;e automatiquement. <a href="/pAbcMember?l=fr" target="_self">[Lire la suite]</a></p>
                        <br/>
                        <h1><a href="/pAboutDonations?l=fr" target="_self">&Agrave; propos des dons</a></h1>
                        <p>Gr&acirc;ce &agrave; votre travail acharn&eacute; et &agrave; celui de tous les Ontariennes et Ontariens, l'Ontario est &agrave; nouveau sur le bon chemin.
                        <a href="/pAboutDonations?l=fr">Voyez comment votre don aide l'Ontario &agrave; avancer ...</a></p>
                    </div>
                    <div class="mmcol" style="float:left; width:260px; padding:20px;">
                        <h1><a href="/pTaxableBenefits?l=fr" target="_self">Cr&eacute;dit d'imp&ocirc;t</a></h1>
                        <p>Aider l'Ontario &agrave; avancer ne co&ucirc;te pas autant que vous le pensez. Par exemple, si vous faites un don de 300 $, vous aurez droit &agrave; un cr&eacute;dit d'imp&ocirc;t de 225 $.
                        <a href="/pTaxableBenefits?l=fr">Apprenez en plus sur les cr&eacute;dits d'imp&ocirc;t, les limites des dons, et les conditions pour verser un don ...</a></p>
                    </div>
                </div>
            ]

            endorsements = CandidateEndorsement.find(:all, :order => "favourite_rate", :conditions => {:riding_id => riding_id, :published => true, :language => language})
            if endorsements == nil || endorsements.length < 3
                megasubmenu_endorsements_en = ""
                megasubmenu_endorsements_fr = ""
            else
                # disable endorsement at pla web site
                megasubmenu_endorsements_en = ""
                megasubmenu_endorsements_fr = ""
            end
            
            site_menu = PlaSiteMenu.find_by_riding_id(riding_id)
            if site_menu != nil && site_menu.menu_en != nil && site_menu.menu_en.strip != ''
                # tempoary code, if mega menu is not '*', set news mega menu to db's value
                if site_menu.menu_en != '*' then megamenu_news_popup_en = site_menu.menu_en end
                if site_menu.menu_fr != '*' then megamenu_news_popup_fr = site_menu.menu_fr end
            else
                # if no value in db, turn off news mega menu
                #megamenu_news_popup_en = '' 
                #megamenu_news_popup_fr = '' 
            end

            if language == 'FR'
                megamenu_str  = "<ul id=\"navbullets\">\n"
                megamenu_str += megamenu_home_fr + "\n"
                megamenu_str += megamenu_about_us_fr + "\n"
                megamenu_str += megamenu_riding_fr + "\n"
                megamenu_str += megamenu_donate_fr + "\n"
                megamenu_str += megamenu_membership_fr + "\n"
                megamenu_str += megamenu_volunteer_fr + "\n"
                megamenu_str += megamenu_news_fr + "\n"
                megamenu_str += megamenu_events_fr + "\n"
                megamenu_str += megamenu_photos_fr + "\n"
                #megamenu_str += megamenu_issues_fr + "\n"
                megamenu_str += megamenu_videos_fr + "\n"
                #megamenu_str += megamenu_contact_fr + "\n"
                megamenu_str += megamenu_enewsletter_fr + "\n"
                #megamenu_str += megamenu_special_fr + "\n"
                megamenu_str += "</ul>\n"
                megamenu_str += "<div id=\"subnavbullets\">\n"
                megamenu_str += "<ul>\n"
                #megamenu_str += megasubmenu_donate_fr + "\n"
                #megamenu_str += megasubmenu_blog_fr + "\n"
                #megamenu_str += megasubmenu_endorsements_fr + "\n"
                #megamenu_str += megasubmenu_enewsletter_fr + "\n"
                #megamenu_str += megasubmenu_membership_fr + "\n"
                #megamenu_str += megasubmenu_accessibility_fr + "\n"
                #megamenu_str += megasubmenu_progress_fr + "\n"
                #megamenu_str += megasubmenu_ontarioliberal_fr + "\n"
                megamenu_str += "</ul>\n"
                megamenu_str += "</div>\n"
                megamenu_str += megamenu_news_popup_fr + "\n"
                megamenu_str += megamenu_photos_popup_fr + "\n"
                megamenu_str += megamenu_donate_popup_fr + "\n"
            else
                megamenu_str  = "<ul id=\"navbullets\">\n"
                megamenu_str += megamenu_home_en + "\n"
                megamenu_str += megamenu_about_us_en + "\n"
                megamenu_str += megamenu_riding_en + "\n"
                megamenu_str += megamenu_donate_en + "\n"
                megamenu_str += megamenu_membership_en + "\n"
                megamenu_str += megamenu_volunteer_en + "\n"
                megamenu_str += megamenu_news_en + "\n"
                megamenu_str += megamenu_events_en + "\n"
                megamenu_str += megamenu_photos_en + "\n"
                #megamenu_str += megamenu_issues_en + "\n"
                megamenu_str += megamenu_videos_en + "\n"
                #megamenu_str += megamenu_contact_en + "\n"
                megamenu_str += megamenu_enewsletter_en + "\n"
                #megamenu_str += megamenu_special_en + "\n"
                megamenu_str += "</ul>\n"
                megamenu_str += "<div id=\"subnavbullets\">\n"
                megamenu_str += "<ul>\n"
                #megamenu_str += megasubmenu_donate_en + "\n"
                #megamenu_str += megasubmenu_blog_en + "\n"
                #megamenu_str += megasubmenu_endorsements_en + "\n"
                #megamenu_str += megasubmenu_enewsletter_en + "\n"
                #megamenu_str += megasubmenu_membership_en + "\n"
                #megamenu_str += megasubmenu_accessibility_en + "\n"
                #megamenu_str += megasubmenu_progress_en + "\n"
                #megamenu_str += megasubmenu_ontarioliberal_en + "\n"
                megamenu_str += "</ul>\n"
                megamenu_str += "</div>\n"
                megamenu_str += megamenu_news_popup_en + "\n"
                megamenu_str += megamenu_photos_popup_en + "\n"
                megamenu_str += megamenu_donate_popup_en + "\n"
            end        
            megamenu_return_str = megamenu_str
        end
        
        megamenu_return_str
    end
    
    def normalize_text_url_break_tag(str_txt)
        if str_txt == nil then str_txt = '' end
        str_lst = (((str_txt.gsub("\r\n", "\n")).gsub("\n", " <br /> ")).gsub("\r", " <br /> ")).split(' ')
        str_txt = ''
        str_lst.each do |str|
            if str.start_with?("http://", "https://")
                str_txt += '<a href="' + str + '" target="_blank">' + str + '</a> '
            elsif str.start_with?("www.")
                str_txt += '<a href="http://' + str + '" target="_blank">' + str + '</a> '
            else
                str_txt += str + ' '
            end
        end
        str_txt
    end

    def localized_date_str(dt, lan, include_weekday=false)
        dt_str = dt.strftime('%B %d, %Y')
        if include_weekday then dt_str = dt.strftime('%A, %B %d %Y') end
        if lan == 'FR'
            if dt.mon == 1
                dt_str = "le " + dt.day.to_s + " janvier " + dt.year.to_s
            elsif dt.mon == 2
                dt_str = "le " + dt.day.to_s + " f&eacute;vrier " + dt.year.to_s
            elsif dt.mon == 3
                dt_str = "le " + dt.day.to_s + " mars " + dt.year.to_s
            elsif dt.mon == 4
                dt_str = "le " + dt.day.to_s + " avril " + dt.year.to_s
            elsif dt.mon == 5
                dt_str = "le " + dt.day.to_s + " mai " + dt.year.to_s
            elsif dt.mon == 6
                dt_str = "le " + dt.day.to_s + " juin " + dt.year.to_s
            elsif dt.mon == 7
                dt_str = "le " + dt.day.to_s + " juillet " + dt.year.to_s
            elsif dt.mon == 8
                dt_str = "le " + dt.day.to_s + " ao&ucirc;t " + dt.year.to_s
            elsif dt.mon == 9
                dt_str = "le " + dt.day.to_s + " septembre " + dt.year.to_s
            elsif dt.mon == 10
                dt_str = "le " + dt.day.to_s + " octobre " + dt.year.to_s
            elsif dt.mon == 11
                dt_str = "le " + dt.day.to_s + " novembre " + dt.year.to_s
            elsif dt.mon == 12
                dt_str = "le " + dt.day.to_s + " d&eacute;cembre " + dt.year.to_s
            end
            if include_weekday
                if dt.wday == 0
                    dt_str = "Dimanche, " + dt_str
                elsif dt.wday == 1
                    dt_str = "Lundi, " + dt_str
                elsif dt.wday == 2
                    dt_str = "Mardi, " + dt_str
                elsif dt.wday == 3
                    dt_str = "Mercredi, " + dt_str
                elsif dt.wday == 4
                    dt_str = "Jeudi, " + dt_str
                elsif dt.wday == 5
                    dt_str = "Vendredi, " + dt_str
                elsif dt.wday == 6
                    dt_str = " Samedi, " + dt_str
                end
            end
        end
        dt_str
    end
    
    def resized_image_url(image_url, width=500, height=337)
        image_buffer_url = 'http://www.service201.net/photos/'
        image_utility_url = 'http://www.service201.net/ImgTool.cgi?w=' + width.to_s + '&h=' + height.to_s + '&s='
        if image_url.start_with?('http://pantone201.ca/webskins/olp/photos/')
            image_utility_url += 'olp&i='
            image_buffer_url += 'olp/'
            image_url['http://pantone201.ca/webskins/olp/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/mpp/photos/')
            image_utility_url += 'mpp&i='
            image_buffer_url += 'mpp/'
            image_url['http://pantone201.ca/webskins/mpp/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/pla/photos/')
            image_utility_url += 'pla&i='
            image_buffer_url += 'pla/'
            image_url['http://pantone201.ca/webskins/pla/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/vote/photos/')
            image_utility_url += 'vote&i='
            image_buffer_url += 'vote/'
            image_url['http://pantone201.ca/webskins/vote/photos/'] = ''
        end
        image_utility_url += image_url
        image_buffer_url += image_url
        image_utility_url['.jpg'] = ''
        image_buffer_url['.jpg'] = '_' + width.to_s + 'x' + height.to_s + '.jpg'
        if Net::HTTP.get_response(URI.parse(image_buffer_url)).kind_of?(Net::HTTPSuccess)
            image_utility_url = image_buffer_url
        end
        image_utility_url
    end
    
	def photo_to_local(photo_url)
		photo_site = 'olp'
		photo_dir = ''
		photo_file = '_PhotoUp.jpg'

		if photo_url.start_with?('http://pantone201.ca/webskins/olp/photos/')
			photo_site = 'olp/'
			photo_url['http://pantone201.ca/webskins/olp/photos/'] = ''
		elsif photo_url.start_with?('http://pantone201.ca/webskins/mpp/photos/')
			photo_site = 'mpp/'
			photo_url['http://pantone201.ca/webskins/mpp/photos/'] = ''
		elsif photo_url.start_with?('http://pantone201.ca/webskins/pla/photos/')
			photo_site = 'pla/'
			photo_url['http://pantone201.ca/webskins/pla/photos/'] = ''
		elsif photo_url.start_with?('http://pantone201.ca/webskins/vote/photos/')
			photo_site = 'vote/'
			photo_url['http://pantone201.ca/webskins/vote/photos/'] = ''
		end

		if photo_url.start_with?('thumbnails/')
			photo_dir = 'thumbnails/'
			photo_url['thumbnails/'] = ''
		end

		if photo_url.end_with?('_PhotoUp.jpg')
			photo_file = '_PhotoUp.jpg'
			photo_url['_PhotoUp.jpg'] = ''
		elsif photo_url.end_with?('_Thumbnail.jpg')
			photo_file = '_Thumbnail.jpg'
			photo_url['_Thumbnail.jpg'] = ''
		end
        if request.port == 80
          if Net::HTTP.get_response(URI.parse('http://' + request.host + '/photos/' + photo_site + photo_dir + photo_url + photo_file)).kind_of?(Net::HTTPSuccess) == false

            open('/home/service201/webdocs/photos/' + photo_site + photo_dir + photo_url + photo_file, 'wb') do |file|
              #external_image = open('http://pantone201.ca/webskins/' + photo_site + 'photos/' + photo_dir + photo_url + photo_file)
              file << open('http://pantone201.ca/webskins/' + photo_site + 'photos/' + photo_dir + photo_url + photo_file).read
            end
          end
        else
          #local development
          save_path = 'public/photos/' + photo_site + photo_dir + photo_url
          save_path_with_filename = Rails.root.join(save_path).to_s + photo_file

          dir = File.dirname(save_path)

          unless File.directory?(dir)
              FileUtils.mkdir_p(dir)
          end

          File.open(save_path_with_filename, 'wb') do |file|
            file << open('http://pantone201.ca/webskins/' + photo_site + 'photos/' + photo_dir + photo_url + photo_file).read
          end
        end
        
        '/photos/' + photo_site + photo_dir + photo_url + photo_file
	end
    

    def unicode_to_utf8(unicode_string)
        unicode_string.gsub(/\\u\w{4}/) do |s|
            str = s.sub(/\\u/, "").hex.to_s(2)
            if str.length < 8
                CGI.unescape(str.to_i(2).to_s(16).insert(0, "%"))
            else
                arr = str.reverse.scan(/\w{0,6}/).reverse.select{|a| a != ""}.map{|b| b.reverse}
                hex = lambda do |s|
                    (arr.first == s ? "1" * arr.length + "0" * (8 - arr.length - s.length) + s : "10" + s).to_i(2).to_s(16).insert(0, "%")
                end
                CGI.unescape(arr.map(&hex).join)
            end
        end
    end
 
    def unicode_to_html(unicode_string)
		unicode_string.gsub(/%u\w{4}/){|s| ('&#x' + s[2,5] + ';')}
    end
 
    def utf8_to_unicode(string) # :nodoc:
        '\\u'+string.unpack("U*").map{|c|"%04x" %c}.join('\\u')
    end

    private 
    
    def customized_menu_item(menu_item, menu_items, default_menu_display_flag=true)
        if menu_items != nil && menu_items.length > 0
            menu_items.each do |customized_item|
                items = customized_item.split('^')
                if items[1] == menu_item
                    menu_item = items[0]
                    default_menu_display_flag = true
                end
            end
        end
        if !default_menu_display_flag then menu_item = '' end
        menu_item
    end
    
    def format_twitter_content(twitter_content)
        if twitter_content != nil && twitter_content != ''
            twitter_content_words = twitter_content.split(' ')
            twitter_content = ''
            twitter_content_words.each do |word|
                if word[0] == '@'
                    twitter_content += " @<a href='http://twitter.com/" + word.delete('@') + "' target='_blank'>" + word.delete('@') + "</a> "
                elsif word[0] == '#'
                    twitter_content += " #<a href='http://twitter.com/#!/search/%23" + word.delete('#') + "' target='_blank'>" + word.delete('#') + "</a> "
                elsif word[0, 5].downcase == 'http:'
                    twitter_content += " <a href='" + word + "' target='_blank'>" + word + "</a> "
                else
                    twitter_content += word + ' '
                end
            end
        end
        twitter_content
    end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def flash_notifications
    message = flash[:error] || flash[:notice]

    if message
      type = flash.keys[0].to_s
      javascript_tag %Q{$.notification({ message:"#{message}", type:"#{type}" });}
    end
  end
    
end
