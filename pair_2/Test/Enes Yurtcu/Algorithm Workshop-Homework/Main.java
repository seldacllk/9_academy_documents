import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        //testParagraphReverser();
        //testSentenceReverser();
        //testVowelCounter();
        //testLetterCounter();
        //testNthPrimeFinder();
    }
    public static void testParagraphReverser() {
        String paragraph = "Java is a popular programming language. It is widely used for building enterprise-level applications! Moreover, it's also favored for Android development.";
        System.out.println("Orijinal paragraf: " + paragraph);
        System.out.println("Ters çevrilmiş paragraf: " + Handler.paragraphReverser(paragraph));
        //Kelimeler orijinal haliyle kaldı.
        //Cümlelerin içerisindeki kelimeler kendi içinde tersten sıralandı.
        //Paragraf içindeki cümleler kendi aralarında tersten sıralandı.
        //Cümleler arasındaki noktalama işaretleri aynı yerlerinde kaldı.
    }
    public static void testSentenceReverser() {
        String sentence = "merhaba dünya";
        System.out.println(Handler.sentenceReverser(sentence));
    }
    private static void testVowelCounter() {
        String string="Merhaba dünya";
        System.out.println(string+" için sesli harf sayısı:" +Handler.vowelCounter(string));
    }

    private static void testLetterCounter() {
        String string="Banana";
        System.out.println(string+" kelimesindeki harflerin sayısı: "+ Handler.countAllLetters(string));
    }
    private static void testNthPrimeFinder() {
        int n=5;
        int prime=Handler.FindNthPrime(n);
        System.out.println(n+". asal sayı: "+ prime);
    }



}