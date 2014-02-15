class VolunteerExtendedProfileController < ApplicationController

    layout "inside_layout"

    def index
        load_application_action
        load_application_layout
        
		is_missing_spambots = true
		if params[:volunteercommet] != nil && params[:volunteercommet].strip != "" then is_missing_spambots = false end
		
		@volunteer_extended_flag_01 = false
		@volunteer_extended_flag_02 = false
		@volunteer_extended_flag_03 = false
		@volunteer_extended_flag_04 = false
		@volunteer_extended_flag_05 = false
		@volunteer_extended_flag_06 = false
		@volunteer_extended_flag_07 = false
		@volunteer_extended_flag_08 = false
		@volunteer_extended_flag_09 = false
		@volunteer_extended_flag_10 = false

		@volunteer_extended_flag_11 = false
		@volunteer_extended_flag_12 = false
		@volunteer_extended_flag_13 = false
		@volunteer_extended_flag_14 = false
		@volunteer_extended_flag_15 = false
		@volunteer_extended_flag_16 = false
		@volunteer_extended_flag_17 = false

		@volunteer_extended_flag_21 = false
		@volunteer_extended_flag_22 = false
		@volunteer_extended_flag_23 = false
		@volunteer_extended_flag_24 = false
		@volunteer_extended_flag_25 = false
		@volunteer_extended_flag_26 = false

		@volunteer_extended_flag_31 = false
		@volunteer_extended_flag_32 = false
		@volunteer_extended_flag_33 = false
		@volunteer_extended_flag_34 = false
		
		@skill_set_note = ''
		@physical_limitation = ''

        if @olp_user != nil
			if @olp_user.profile_extended > 0
				skill_sets = nil
				if @olp_user.skill_set != nil && @olp_user.skill_set != ''
					skill_sets = @olp_user.skill_set.split('|')
					if skill_sets != nil && skill_sets.length > 0
						skill_set_hash = Hash.new
						skill_sets.each do |skill_set|
							skill_set_hash[skill_set] = true
						end
						if skill_set_hash['AC_SP']   == true then @volunteer_extended_flag_01 = true end # Arts and Creative : Still Photography
						if skill_set_hash['AC_VP']   == true then @volunteer_extended_flag_02 = true end # Arts and Creative : Video Production
						if skill_set_hash['AC_GD']   == true then @volunteer_extended_flag_03 = true end # Arts and Creative : Graphic Design (RGD)
						if skill_set_hash['AC_VAM']  == true then @volunteer_extended_flag_04 = true end # Arts and Creative : Voice Acting/Modelling
						if skill_set_hash['AC_SD']   == true then @volunteer_extended_flag_05 = true end # Arts and Creative : Set Design
						if skill_set_hash['AC_SCW']  == true then @volunteer_extended_flag_06 = true end # Arts and Creative : Screenwriter/Copy Writer
						if skill_set_hash['AC_WD']   == true then @volunteer_extended_flag_07 = true end # Arts and Creative : Web Design (HTML)
						if skill_set_hash['AC_CM']   == true then @volunteer_extended_flag_08 = true end # Arts and Creative : Composer/Musician
						if skill_set_hash['AC_MGD']  == true then @volunteer_extended_flag_09 = true end # Arts and Creative : Motion Graphics/3D Modelling
						if skill_set_hash['AC_PIE']  == true then @volunteer_extended_flag_10 = true end # Arts and Creative : Photoshop/Image Editing
						if skill_set_hash['AIT_DM']  == true then @volunteer_extended_flag_11 = true end # Analysis and Information Technology : Data mining/analysis/spss
						if skill_set_hash['AIT_PA']  == true then @volunteer_extended_flag_12 = true end # Analysis and Information Technology : Process analysis
						if skill_set_hash['AIT_P']   == true then @volunteer_extended_flag_13 = true end # Analysis and Information Technology : Programming (VB, C#, Ruby etc...)
						if skill_set_hash['AIT_AG']  == true then @volunteer_extended_flag_14 = true end # Analysis and Information Technology : ArcView/GIS mapping
						if skill_set_hash['AIT_ES']  == true then @volunteer_extended_flag_15 = true end # Analysis and Information Technology : Excel and spreadsheets
						if skill_set_hash['AIT_EM']  == true then @volunteer_extended_flag_16 = true end # Analysis and Information Technology : Email Marketing and execution
						if skill_set_hash['AIT_SQL'] == true then @volunteer_extended_flag_17 = true end # Analysis and Information Technology : SQL
						if skill_set_hash['EE_TLE']  == true then @volunteer_extended_flag_21 = true end # Election Experience : Trained on LibE
						if skill_set_hash['EE_C']    == true then @volunteer_extended_flag_22 = true end # Election Experience : Canvassing
						if skill_set_hash['EE_TL']   == true then @volunteer_extended_flag_23 = true end # Election Experience : Trained on Liberalist
						if skill_set_hash['EE_TT']   == true then @volunteer_extended_flag_24 = true end # Election Experience : Telemarketing/Tele-research
						if skill_set_hash['EE_CM']   == true then @volunteer_extended_flag_25 = true end # Election Experience : Campaign Manager
						if skill_set_hash['EE_DB']   == true then @volunteer_extended_flag_26 = true end # Election Experience : Digital ad buying
						if skill_set_hash['O_PPA']   == true then @volunteer_extended_flag_31 = true end # Other : Printing/Print Acquisition
						if skill_set_hash['O_AB']    == true then @volunteer_extended_flag_32 = true end # Other : Ad buying
						if skill_set_hash['O_SP']    == true then @volunteer_extended_flag_33 = true end # Other : Screen Printing
						if skill_set_hash['O_A']     == true then @volunteer_extended_flag_34 = true end # Other : Accounting
					end
				end
				@skill_set_note = @olp_user.skill_set_note
				@physical_limitation = @olp_user.physical_limitation
			end
			if @olp_user.profile_extended < 999
				skill_set = "|"
				if params[:volunteerextended01] != nil && params[:volunteerextended01].strip != "" then skill_set += "AC_SP|"   end # Arts and Creative : Still Photography
				if params[:volunteerextended02] != nil && params[:volunteerextended02].strip != "" then skill_set += "AC_VP|"   end # Arts and Creative : Video Production
				if params[:volunteerextended03] != nil && params[:volunteerextended03].strip != "" then skill_set += "AC_GD|"   end # Arts and Creative : Graphic Design (RGD)
				if params[:volunteerextended04] != nil && params[:volunteerextended04].strip != "" then skill_set += "AC_VAM|"  end # Arts and Creative : Voice Acting/Modelling
				if params[:volunteerextended05] != nil && params[:volunteerextended05].strip != "" then skill_set += "AC_SD|"   end # Arts and Creative : Set Design
				if params[:volunteerextended06] != nil && params[:volunteerextended06].strip != "" then skill_set += "AC_SCW|"  end # Arts and Creative : Screenwriter/Copy Writer
				if params[:volunteerextended07] != nil && params[:volunteerextended07].strip != "" then skill_set += "AC_WD|"   end # Arts and Creative : Web Design (HTML)
				if params[:volunteerextended08] != nil && params[:volunteerextended08].strip != "" then skill_set += "AC_CM|"   end # Arts and Creative : Composer/Musician
				if params[:volunteerextended09] != nil && params[:volunteerextended09].strip != "" then skill_set += "AC_MGD|"  end # Arts and Creative : Motion Graphics/3D Modelling
				if params[:volunteerextended10] != nil && params[:volunteerextended10].strip != "" then skill_set += "AC_PIE|"  end # Arts and Creative : Photoshop/Image Editing
				if params[:volunteerextended11] != nil && params[:volunteerextended11].strip != "" then skill_set += "AIT_DM|"  end # Analysis and Information Technology : Data mining/analysis/spss
				if params[:volunteerextended12] != nil && params[:volunteerextended12].strip != "" then skill_set += "AIT_PA|"  end # Analysis and Information Technology : Process analysis
				if params[:volunteerextended13] != nil && params[:volunteerextended13].strip != "" then skill_set += "AIT_P|"   end # Analysis and Information Technology : Programming (VB, C#, Ruby etc...)
				if params[:volunteerextended14] != nil && params[:volunteerextended14].strip != "" then skill_set += "AIT_AG|"  end # Analysis and Information Technology : ArcView/GIS mapping
				if params[:volunteerextended15] != nil && params[:volunteerextended15].strip != "" then skill_set += "AIT_ES|"  end # Analysis and Information Technology : Excel and spreadsheets
				if params[:volunteerextended16] != nil && params[:volunteerextended16].strip != "" then skill_set += "AIT_EM|"  end # Analysis and Information Technology : Email Marketing and execution
				if params[:volunteerextended17] != nil && params[:volunteerextended17].strip != "" then skill_set += "AIT_SQL|" end # Analysis and Information Technology : SQL
				if params[:volunteerextended21] != nil && params[:volunteerextended21].strip != "" then skill_set += "EE_TLE|"  end # Election Experience : Trained on LibE
				if params[:volunteerextended22] != nil && params[:volunteerextended22].strip != "" then skill_set += "EE_C|"    end # Election Experience : Canvassing
				if params[:volunteerextended23] != nil && params[:volunteerextended23].strip != "" then skill_set += "EE_TL|"   end # Election Experience : Trained on Liberalist
				if params[:volunteerextended24] != nil && params[:volunteerextended24].strip != "" then skill_set += "EE_TT|"   end # Election Experience : Telemarketing/Tele-research
				if params[:volunteerextended25] != nil && params[:volunteerextended25].strip != "" then skill_set += "EE_CM|"   end # Election Experience : Campaign Manager
				if params[:volunteerextended26] != nil && params[:volunteerextended26].strip != "" then skill_set += "EE_DB|"   end # Election Experience : Digital ad buying
				if params[:volunteerextended31] != nil && params[:volunteerextended31].strip != "" then skill_set += "O_PPA|"   end # Other : Printing/Print Acquisition
				if params[:volunteerextended32] != nil && params[:volunteerextended32].strip != "" then skill_set += "O_AB|"    end # Other : Ad buying
				if params[:volunteerextended33] != nil && params[:volunteerextended33].strip != "" then skill_set += "O_SP|"    end # Other : Screen Printing
				if params[:volunteerextended34] != nil && params[:volunteerextended34].strip != "" then skill_set += "O_A|"     end # Other : Accounting
				if params[:volunteerextended92] != nil && params[:volunteerextended92].strip != "" then @skill_set_note = CGI.unescapeHTML(params[:volunteerextended92].strip) end
				if params[:volunteerextended91] != nil && params[:volunteerextended91].strip != "" then @physical_limitation = CGI.unescapeHTML(params[:volunteerextended91].strip) end
				@olp_user.skill_set = skill_set
				@olp_user.skill_set_note = @skill_set_note
				@olp_user.physical_limitation = @physical_limitation
				@olp_user.profile_extended = 1
				if is_missing_spambots && params[:commit] == "Submit"
					@olp_user.save
					redirect_to :controller => 'VolunteerExtendedProfile'
				end
			end
        end
    end

	def show
	end

end
