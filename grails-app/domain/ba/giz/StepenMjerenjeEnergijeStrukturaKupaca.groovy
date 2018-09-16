package ba.giz

class StepenMjerenjeEnergijeStrukturaKupaca {

  Long domacinstvoBrojMjerenjePotrosnje
  Long domacinstvoUkupanBroj
  Long domacinstvoBrojDaljinskoOcitavanje

  Long industrijaBrojMjerenjePotrosnje
  Long industrijaUkupanBroj
  Long industrijaBrojDaljinskoOcitavanje

  Long ostaloBrojMjerenjePotrosnje
  Long ostaloUkupanBroj
  Long ostaloBrojDaljinskoOcitavanje

  Long ukupnoBrojMjerenjePotrosnje
  Long ukupnoBrojKrajnjihKupaca
  Long ukupnoBrojDaljinskoOcitavanje

  static constraints = {
    domacinstvoBrojMjerenjePotrosnje nullable: true
    domacinstvoUkupanBroj nullable: true
    domacinstvoBrojDaljinskoOcitavanje nullable: true

    industrijaBrojMjerenjePotrosnje nullable: true
    industrijaUkupanBroj nullable: true
    industrijaBrojDaljinskoOcitavanje nullable: true

    ostaloBrojMjerenjePotrosnje nullable: true
    ostaloUkupanBroj nullable: true
    ostaloBrojDaljinskoOcitavanje nullable: true

    ukupnoBrojMjerenjePotrosnje nullable: true
    ukupnoBrojKrajnjihKupaca nullable: true
    ukupnoBrojDaljinskoOcitavanje nullable: true
  }
}
