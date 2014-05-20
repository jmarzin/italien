class Forme < ActiveRecord::Base
  validates :rang_forme, presence: {message: 'Le rang de la forme est obligatoire'}
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
['inf.pres.s1','Io','1ère personne singulier présent indicatif'],
['inf.imp.s1','Io','1ère personne singulier imparfait indicatif'],
['inf.parf.s1','Io','1ère personne singulier parfait indicatif'],
['inf.fut.s1','Io','1ère personne singulier futur indicatif'],
['inf.pres.s2','Tu','2ème personne singulier présent indicatif'],
['inf.imp.s2','Tu','2ème personne singulier imparfait indicatif'],
['inf.parf.s2','Tu','2ème personne singulier parfait indicatif'],
['inf.fut.s2','Tu','2ème personne singulier futur indicatif'],
['inf.pres.s3','Lui/lei','3ème personne singulier présent indicatif'],
['inf.imp.s3','Lui/lei','3ème personne singulier imparfait indicatif'],
['inf.parf.s3','Lui/lei','3ème personne singulier parfait indicatif'],
['inf.fut.s3','Lui/lei','3ème personne singulier futur indicatif'],
['inf.pres.p1','Noi','1ère personne pluriel présent indicatif'],
['inf.imp.p1','Noi','1ère personne pluriel imparfait indicatif'],
['inf.parf.p1','Noi','1ère personne pluriel parfait indicatif'],
['inf.fut.p1','Noi','1ère personne pluriel futur indicatif'],
['inf.pres.p2','Voi','2ème personne pluriel présent indicatif'],
['inf.imp.p2','Voi','2ème personne pluriel imparfait indicatif'],
['inf.parf.p2','Voi','2ème personne pluriel parfait indicatif'],
['inf.fut.p2','Voi','2ème personne pluriel futur indicatif'],
['inf.pres.p3','Loro','3ème personne pluriel présent indicatif'],
['inf.imp.p3','Loro','3ème personne pluriel imparfait indicatif'],
['inf.parf.p3','Loro','3ème personne pluriel parfait indicatif'],
['inf.fut.p3','Loro','3ème personne pluriel futur indicatif'],
['sub.pres.s1','Che io','1ère personne singulier présent subjonctif'],
['sub.imp.s1','Che io','1ère personne singulier imparfait subjonctif'],
['imp.s1','',''],
['cond.pres.s1','Io','1ère personne singulier présent conditionnel'],
['sub.pres.s2','Che tu','2ème personne singulier présent subjonctif'],
['sub.imp.s2','Che tu','2ème personne singulier imparfait subjonctif'],
['imp.s2',''],'2ème personne singulier impératif',
['cond.pres.s2','Tu','2ème personne singulier présent conditionnel'],
['sub.pres.s3','Che lui/lei','3ème personne singulier présent subjonctif'],
['sub.imp.s3','Che lui/lei','3ème personne singulier imparfait subjonctif'],
['imp.s3','','3ème personne singulier impératif'],
['cond.pres.s3','Lui/lei','3ème personne singulier présent conditionnel'],
['sub.pres.p1','Che noi','1ère personne pluriel présent subjonctif'],
['sub.imp.p1','Che noi','1ère personne pluriel imparfait subjonctif'],
['imp.p1','','1ère personne pluriel impératif'],
['cond.pres.p1','Noi','1ère personne pluriel présent conditionnel'],
['sub.pres.p2','Che voi','2ème personne pluriel présent subjonctif'],
['sub.imp.p2','Che voi','2ème personne pluriel imparfait subjonctif'],
['imp.p2','','2ème personne pluriel impératif'],
['cond.pres.p2','Voi','2ème personne pluriel présent conditionnel'],
['sub.pres.p3','Che loro','3ème personne pluriel présent subjonctif'],
['sub.imp.p3','Che loro','3ème personne pluriel imparfait subjonctif'],
['imp.p3','','3ème personne pluriel impératif'],
['cond.pres.p3','Loro','3ème personne pluriel présent conditionnel'],
['ger','','gérondif'],
['ppas','','participe passé']
  ]


end
