class Forme < ActiveRecord::Base
#  validates :rang_forme, presence: {message: 'Le rang de la forme est obligatoire'}
  validates :italien, presence: {message: 'La forme en italien est obligatoire' }

  belongs_to :verbe

  has_many :scores_formes, dependent: :destroy
  accepts_nested_attributes_for :scores_formes
  has_many :erreurs, dependent: :destroy
  has_many :users, through: :scores_formes

  MAX_ESSAIS = 8
  SUCCES = 0.5
  ECHEC = 2

  FORMES = [
['ind.pres.s1','Io','1ère personne singulier présent indicatif'],
['ind.pres.s2','Tu','2ème personne singulier présent indicatif'],
['ind.pres.s3','Lui/lei','3ème personne singulier présent indicatif'],
['ind.pres.p1','Noi','1ère personne pluriel présent indicatif'],
['ind.pres.p2','Voi','2ème personne pluriel présent indicatif'],
['ind.pres.p3','Loro','3ème personne pluriel présent indicatif'],
['ind.imp.s1','Io','1ère personne singulier imparfait indicatif'],
['ind.imp.s2','Tu','2ème personne singulier imparfait indicatif'],
['ind.imp.s3','Lui/lei','3ème personne singulier imparfait indicatif'],
['ind.imp.p1','Noi','1ère personne pluriel imparfait indicatif'],
['ind.imp.p2','Voi','2ème personne pluriel imparfait indicatif'],
['ind.imp.p3','Loro','3ème personne pluriel imparfait indicatif'],
['ind.parf.s1','Io','1ère personne singulier parfait indicatif'],
['ind.parf.s2','Tu','2ème personne singulier parfait indicatif'],
['ind.parf.s3','Lui/lei','3ème personne singulier parfait indicatif'],
['ind.parf.p1','Noi','1ère personne pluriel parfait indicatif'],
['ind.parf.p2','Voi','2ème personne pluriel parfait indicatif'],
['ind.parf.p3','Loro','3ème personne pluriel parfait indicatif'],
['ind.fut.s1','Io','1ère personne singulier futur indicatif'],
['ind.fut.s2','Tu','2ème personne singulier futur indicatif'],
['ind.fut.s3','Lui/lei','3ème personne singulier futur indicatif'],
['ind.fut.p1','Noi','1ère personne pluriel futur indicatif'],
['ind.fut.p2','Voi','2ème personne pluriel futur indicatif'],
['ind.fut.p3','Loro','3ème personne pluriel futur indicatif'],
['sub.pres.s1','Che io','1ère personne singulier présent subjonctif'],
['sub.pres.s2','Che tu','2ème personne singulier présent subjonctif'],
['sub.pres.s3','Che lui/lei','3ème personne singulier présent subjonctif'],
['sub.pres.p1','Che noi','1ère personne pluriel présent subjonctif'],
['sub.pres.p2','Che voi','2ème personne pluriel présent subjonctif'],
['sub.pres.p3','Che loro','3ème personne pluriel présent subjonctif'],
['sub.imp.s1','Che io','1ère personne singulier imparfait subjonctif'],
['sub.imp.s2','Che tu','2ème personne singulier imparfait subjonctif'],
['sub.imp.s3','Che lui/lei','3ème personne singulier imparfait subjonctif'],
['sub.imp.p1','Che noi','1ère personne pluriel imparfait subjonctif'],
['sub.imp.p2','Che voi','2ème personne pluriel imparfait subjonctif'],
['sub.imp.p3','Che loro','3ème personne pluriel imparfait subjonctif'],
['imp.s1','',''],
['imp.s2','','2ème personne singulier impératif'],
['imp.s3','','3ème personne singulier impératif'],
['imp.p1','','1ère personne pluriel impératif'],
['imp.p2','','2ème personne pluriel impératif'],
['imp.p3','','3ème personne pluriel impératif'],
['cond.pres.s1','Io','1ère personne singulier présent conditionnel'],
['cond.pres.s2','Tu','2ème personne singulier présent conditionnel'],
['cond.pres.s3','Lui/lei','3ème personne singulier présent conditionnel'],
['cond.pres.p1','Noi','1ère personne pluriel présent conditionnel'],
['cond.pres.p2','Voi','2ème personne pluriel présent conditionnel'],
['cond.pres.p3','Loro','3ème personne pluriel présent conditionnel'],
['ger','','gérondif'],
['ppas','','participe passé']
  ]


end
