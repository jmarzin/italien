class Forme < ActiveRecord::Base

  belongs_to :verbe

  has_many :scores_formes, dependent: :destroy
  accepts_nested_attributes_for :scores_formes
  has_many :erreurs, as: :en_erreur, dependent: :destroy
  has_many :users, through: :scores_formes

  TEMPS = [
      ['Indicatif présent',0..5],
      ['Indicatif imparfait',6..11],
      ['Indicatif parfait',12..17],
      ['Indicatif futur',18..23],
      ['Subjonctif présent',24..29],
      ['Subjonctif imparfait',30..35],
      ['Impératif',36..41],
      ['Conditionnel présent',42..47],
      ['Gérondif',48..48],
      ['Participe passé',49..49]
  ]

  FORMES = [
['ind.pres.s1','Io','1ère personne singulier présent indicatif',8],
['ind.pres.s2','Tu','2ème personne singulier présent indicatif',8],
['ind.pres.s3','Lui/lei','3ème personne singulier présent indicatif',8],
['ind.pres.p1','Noi','1ère personne pluriel présent indicatif',8],
['ind.pres.p2','Voi','2ème personne pluriel présent indicatif',8],
['ind.pres.p3','Loro','3ème personne pluriel présent indicatif',8],
['ind.imp.s1','Io','1ère personne singulier imparfait indicatif',8],
['ind.imp.s2','Tu','2ème personne singulier imparfait indicatif',8],
['ind.imp.s3','Lui/lei','3ème personne singulier imparfait indicatif',8],
['ind.imp.p1','Noi','1ère personne pluriel imparfait indicatif',8],
['ind.imp.p2','Voi','2ème personne pluriel imparfait indicatif',8],
['ind.imp.p3','Loro','3ème personne pluriel imparfait indicatif',8],
['ind.parf.s1','Io','1ère personne singulier parfait indicatif',1],
['ind.parf.s2','Tu','2ème personne singulier parfait indicatif',1],
['ind.parf.s3','Lui/lei','3ème personne singulier parfait indicatif',1],
['ind.parf.p1','Noi','1ère personne pluriel parfait indicatif',1],
['ind.parf.p2','Voi','2ème personne pluriel parfait indicatif',1],
['ind.parf.p3','Loro','3ème personne pluriel parfait indicatif',1],
['ind.fut.s1','Io','1ère personne singulier futur indicatif',8],
['ind.fut.s2','Tu','2ème personne singulier futur indicatif',8],
['ind.fut.s3','Lui/lei','3ème personne singulier futur indicatif',8],
['ind.fut.p1','Noi','1ère personne pluriel futur indicatif',8],
['ind.fut.p2','Voi','2ème personne pluriel futur indicatif',8],
['ind.fut.p3','Loro','3ème personne pluriel futur indicatif',8],
['sub.pres.s1','Che io','1ère personne singulier présent subjonctif',8],
['sub.pres.s2','Che tu','2ème personne singulier présent subjonctif',8],
['sub.pres.s3','Che lui/lei','3ème personne singulier présent subjonctif',8],
['sub.pres.p1','Che noi','1ère personne pluriel présent subjonctif',8],
['sub.pres.p2','Che voi','2ème personne pluriel présent subjonctif',8],
['sub.pres.p3','Che loro','3ème personne pluriel présent subjonctif',8],
['sub.imp.s1','Che io','1ère personne singulier imparfait subjonctif',2],
['sub.imp.s2','Che tu','2ème personne singulier imparfait subjonctif',2],
['sub.imp.s3','Che lui/lei','3ème personne singulier imparfait subjonctif',2],
['sub.imp.p1','Che noi','1ère personne pluriel imparfait subjonctif',2],
['sub.imp.p2','Che voi','2ème personne pluriel imparfait subjonctif',2],
['sub.imp.p3','Che loro','3ème personne pluriel imparfait subjonctif',2],
['imp.s1','',''],
['imp.s2','','2ème personne singulier impératif',8],
['imp.s3','','3ème personne singulier impératif',8],
['imp.p1','','1ère personne pluriel impératif',8],
['imp.p2','','2ème personne pluriel impératif',8],
['imp.p3','','3ème personne pluriel impératif',8],
['cond.pres.s1','Io','1ère personne singulier présent conditionnel',8],
['cond.pres.s2','Tu','2ème personne singulier présent conditionnel',8],
['cond.pres.s3','Lui/lei','3ème personne singulier présent conditionnel',8],
['cond.pres.p1','Noi','1ère personne pluriel présent conditionnel',8],
['cond.pres.p2','Voi','2ème personne pluriel présent conditionnel',8],
['cond.pres.p3','Loro','3ème personne pluriel présent conditionnel',8],
['ger','','gérondif',8],
['ppas','','participe passé',8]
  ]

  def question_en_francais
    Forme::FORMES[self.rang_forme][2]+' du verbe '+self.verbe.infinitif
  end

  def self.api_v1
    liste = []
    Forme.order(:verbe_id, :rang_forme).each do |forme|
      if forme.rang_forme <= 23 then
        i = forme.rang_forme + 3
      elsif forme.rang_forme <= 35 then
        i = forme.rang_forme + 9
      elsif forme.rang_forme <= 36 then
        i = 0
      elsif forme.rang_forme <= 41 then
        i = forme.rang_forme + 8
      elsif forme.rang_forme <= 47 then
        i = forme.rang_forme - 17
      else
        i = forme.rang_forme - 47
      end
      if i > 0 then
        liste << [forme.verbe_id, i, forme.italien]
      end
    end
    liste
  end

  def self.api_v2
    liste = []
    Forme.order(:verbe_id, :rang_forme).each do |forme|
      if forme.rang_forme <= 23 then
        i = forme.rang_forme + 3
      elsif forme.rang_forme <= 35 then
        i = forme.rang_forme + 9
      elsif forme.rang_forme <= 36 then
        i = 0
      elsif forme.rang_forme <= 41 then
        i = forme.rang_forme + 8
      elsif forme.rang_forme <= 47 then
        i = forme.rang_forme - 15
      else
        i = forme.rang_forme - 47
      end
      if i > 0 then
        liste << [forme.id, forme.verbe_id, i, forme.italien]
      end
    end
    liste
  end
end
