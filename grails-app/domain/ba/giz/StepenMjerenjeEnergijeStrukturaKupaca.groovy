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

  }
}
