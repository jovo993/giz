package ba.giz

import pl.touk.excel.export.getters.Getter
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

class MsgFromPropertyGetter implements Getter {
    private MessageSource messageSource
    private String prefiks
    private String propertyName1
    private String propertyName2
    private Locale locale

    MsgFromPropertyGetter(MessageSource messageSource, String prefiks, String propertyName1, Locale locale) {
        this.messageSource = messageSource
        this.prefiks = prefiks
        this.propertyName1 = propertyName1
        this.propertyName2 = null
        this.locale = locale
    }

    MsgFromPropertyGetter(MessageSource messageSource, String prefiks, String propertyName1, String propertyName2, Locale locale) {
        this.messageSource = messageSource
        this.prefiks = prefiks
        this.propertyName1 = propertyName1
        this.propertyName2 = propertyName2
        this.locale = locale
    }

    String getPropertyName() {
        return ""
    }

    Object getFormattedValue(Object object) {
        // BB: originalni return prema https://github.com/TouK/excel-export/blob/master/src/main/groovy/pl/touk/excel/export/getters/MessageFromPropertyGetter.groovy
        // return messageSource.getMessage(object.getProperties().get(propertyName), [].toArray(), object.getProperties().get(propertyName), locale)

        // BB: Izbacen je konstruktor MsgFromPropertyGetter koji ne prihvata parametar "locale", a dodat je parametar "prefiks"
        //     Malo je modifikovan poziv messageSource.getMessage()
        def msg
        if (propertyName2==null) {
           msg = messageSource.getMessage(prefiks + object.getProperties().get(propertyName1).toString(), null, locale)
        } else {
           msg = messageSource.getMessage(prefiks + object.getProperties().get(propertyName1).getProperties().get(propertyName2).toString(), null, locale)
        }
        return msg
        // return prefiks + object.getProperties().get(propertyName).toString()
        // return object.getProperties().get("preduzece").getProperties().get("sektor").toString()
        // return object.getProperties().get(propertyName).toString()
    }

}