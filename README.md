Zadanie Projektowe na przedmiot Niezależność i Diagnostyka Układów Cyfrowych 2

Projekt ten ma za zadanie zaimplementować symulacje przesyłania wiadomości i wykrywania błędów które mogły nastąpić podczas transmisji.
Jako wiadomości będziemy przesyłać łańcuchy znaków i obrazy (z góry ustalone i generowane losowo) które będą przekazywane do funkcji symulującej transmisje. Funkcja ta będzie z różnym prawdopodobieństwem i w różnym stopniu modyfikowała wiadomości. Następnie wiadomosć wysłana i odebrana będą porównywane za pomocą różnych algorytmów. Porównywane też będą rezultaty tych algorytmów - które wykryją a które nie wykryją zmodyfikowania wiadomości.

W programie wykorzystano następujące algorytmy wykrywania błędów :

1. Kontola parzystości (bit parzystości) - polega na dodawaniu do wysłanej wiadomości bitu kontrolnego, który przyjmuje waartość 1, gdy liczba jednynek w przesłanej wiadomości jest nieparzysta, lub 0 gdy jest parzysta
                                           
2. Cykliczny kod nadmiarowy (Cyclic Redundancy Check, CRC) - system sum kontrolnych, n-bitowy cykliczny kod nadmiarowy (n-bitowy CRC) definiuje się jako resztę z dzielenia ciągu danych przez (n+1)-bitowy dzielnik CRC, zwany również wielomianem CRC

3. Sumy kontrolne z wykorzystanie MD5 (Message-Digest algorithm 5) - algorytm kryptograficzny, który z ciągu danych o dowolnej długości generuje 128 bitowy skrót (sumę kontrolną). 

Algorytm MD5 jest następujący:

  1. Doklejamy do wiadomości wejściowej bit o wartości 
  2. Doklejamy tyle zer ile trzeba żeby ciąg składał się z 512-bitowych bloków, i ostatniego niepełnego - 448-bitowego
  3. Doklejamy 64-bitowy (zaczynając od najmniej znaczącego bitu) licznik oznaczający rozmiar wiadomości. W ten sposób otrzymujemy              wiadomość złożoną z 512-bitowych fragmentów.
  4. Ustawiamy stan początkowy na 0123456789abcdeffedcba9876543210
  5. Uruchamiamy na każdym bloku (jest przynajmniej jeden blok nawet dla pustego wejścia) funkcję zmieniającą stan
  6 .Po przetworzeniu ostatniego bloku zwracamy stan jako obliczony skrót wiadomości

Algorytm MD5 został wybrany, ponieważ już od kilku lat istnieją ataki pozwalające na stworzenie dwóch różnych wiadomości o tej samej sumie kontrolnej. W tym projekcie chcemy zaprezentować taki właśnie atak - stworzenie dwóch różnych wiadomości i obrazów które będą miały tą samą sumę kontrolną. MD5 pomimo znanych atakótw kryptoanalitycznych wciąż jest często wykorzystywany.
