class SauveController < ApplicationController

  before_action :authenticate_user!

  def lance
    unless current_user.admin
      redirect_to mots_path, notice: "Vous ne pouvez pas sauvegarder les mots et formes verbales"
    end
  end

  def ecrit
    unless current_user.admin
      redirect_to mots_path, notice: "Vous ne pouvez pas sauvegarder les mots et formes verbales"
    end
    Mot.sauve(current_user.id)
    Verbe.sauve
    Category.sauve
    redirect_to mots_path, notice: "Mots et formes verbales sauvegardées."
  end

end