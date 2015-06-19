# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# III Tarea Programada
# Ruby on Rails/ Bootstrap/ Angular
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015


# Generated Omniaoth controller to control the Oath authentications.
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
 
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end