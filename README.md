# ROBOT SİMÜLASYONU (3 Degrees of freedom)

Bu projede bir robot simülasyonu oluşturacağız.

İlk önce boş bir matlab dosyası açıp komut satırına "guide" yazıyoruz, default GUI yi seçiyoruz ve karşımıza çıkan ".fig" penceresinde yapacağımız aryüzü oluşturmaya başlıyoruz.

> NOT: Eğer oluşturulan proje çalışmazsa sorun aryüzün toolarının yetersizliğindendir. Matlab a yeni toollar yükleyerek arayüzden oluşacak sorunlardan kurtulabilirsiniz.

# GUI OLUŞTURMA

Karşımıza çıkan pencereden arayüzü oluşturmak oldukça kolaydr. Öncelikle robot simülasyonuna neler yaptırmak istediğinizi ve kaç linkli olacağı gibi konuları kafanızda kurup ona göre oluşturmaya başlamanız sizin için iyi olackatır.

Projemizde 3 linkli ve XYZ koordinatlarında hareket eden bir robot kolu tasarlayacağız ve bunun için bize lazım olan araçları soldaki araçlar menüsünden seçip sağdaki boş bölgelere sürükleyerek yerleştiriyoruz.

Edit Text : Soldaki menüde bulunan "edit text" den 6 tane kullanacağız. Çünkü 3 tanesi bizim gireceğimiz açılar için, 3 tanesi de girdiğimiz açıların XYZ koordinatlarındaki tekabül ettiği noktalar için.

Push Button : Adından da anlaşılacağı gibi bunlar butonlardır. Birinci butonu, istediğimiz açıları "edit text" e giridkten sonra onaylamak için kullanacağız. İkinci butonu ise robot kolun o tersini almak için kullanacağız. Butonlardan birisinin ismini "Tamam"
diğerinin ismini de " Tersini Al" yaptık.

Axes : Robot kolunu simülasyon haline getirilmesi için kullnacağız. Programı çalıştırdığımızda girdiğimiz açılara göre robot kolu hareketini yapacaktır.

Static Text: Kullandığımız "edit text" lerin üzerine yerleştiridik. Arayüzde bunu kullanarak yazı yazılabilir. İstediğiniz yere yerleştirebilir ve belirtmek istediğiz şeyleri isimlendirebilirsiniz. Biz bu projede "edit text" lerin açıları belirttiğini göstermek için kullandık. İki kere "static text" e tıkladıktan sonra karşınıza çıkan pencereden "string" bölümünden istediğinizi yazabilirsiniz, diğer araçlar için de isim değiştirme yolu aynıdır. Biz ismini "AÇI 1 , AÇI 2 , AÇI 3" yaptık.

> NOT : GUI üzerinde değişiklik yapmak isterseniz oluşturduğunuz ".fig" dosyası üzerine gelerek sağ tıklayıp  "Open in GUİDE" seçeneği ile istediğiniz değişikliği ve düzenlemeyi yapabilirsiniz. 


# CALLBACK İLE PROGRAMIN OLUŞTURULMASI

Arayüzdeki herhangi bir araca sağ tık yapıp Callback(bkz. Wiew Callbacks>Callback) e tıkladıktan sonra program kendi kendine oluşacaktır. Örneğin oluşturduğumuz "edit text" üzerinden sağ tık ile programı oluşturabiliriniz. 

NOT : Programın oluşturulmuş yalın haline, yüklediğim "yalinkod.m" matlab dosyasından bakabilirsiniz.

# OLUŞAN PROGRAMA EKLEMELER YAPARAK BİTİRMEK

Programda ekleme yapcağımız yerler;

>> function pushbutton1_Callback(hObject, eventdata, handles)

>> function pushbutton2_Callback(hObject, eventdata, handles)

> NOT : Bu satırlar ve diğer satırlar "Callback" yapınca kendi kendine oluşmuştur.

Bu satırların altına bazı değerler tanımlayacağız.



Girdiğimiz açılara göre robotu hareket ettireceğimiz "pushbutton1" satırı altına şunları yazıyoruz; 

Acii_1 = str2double(handles.Aci_1.String)*pi/180;  % Kullanıcı tarafından girilen açıları "double" formatına çevriyoruz.

Acii_2 = str2double(handles.Aci_2.String)*pi/180;

Acii_3 = str2double(handles.Aci_3.String)*pi/180;


L_1 = 20;

L_2 = 50;

L_3 = 40;


L (1) = Link([0 L_1 0 pi/2]);

L (2) = Link([0 0 L_2 0]);

L (3) = Link([0 0 L_3 0]);


Robot = SerialLink(L);

Robot.name = 'ROBOTIK';

Robot.plot([Acii_1 Acii_2 Acii_3]);


T = Robot.fkine([Acii_1 Acii_2 Acii_3]);

handles.KorX.String = num2str(floor(T(1,4)));

handles.KorY.String = num2str(floor(T(2,4)));

handles.KorZ.String = num2str(floor(T(3,4)));






Ters alma işlemini yapacağımız "pushbutton2" satırının alt satırlarına şunları yazıyoruz;

KorX = str2double(handles.Kor_1.String); % X , Y ve  Z içine yazılı olan string değerlerini kullanbilmek için "double" formatına çevirdik.

KorY = str2double(handles.Kor_2.String);

KorZ = str2double(handles.Kor_3.String);

L_1 = 20; % L(1) ve diğerleri içinde kullanmak için değerler atadık.

L_2 = 50;

L_3 = 40;

L (1) = Link([0 L_1 0 pi/2]); 

L (2) = Link([0 0 L_2 0]);

L (3) = Link([0 0 L_3 0]);

Robot = SerialLink(L); % Robot için linkleri ayarladık.

Robot.name = 'ROBOTIK'; % Arayüzdeki robotun ismini tanımladık.

% T= Kullanıcını girdiği açıları kullanarak dönderme hareketi yapmak için kullanılır.

T = [ 1 0 0 PX ;
      0 1 0 PY ; 
      0 0 1 PZ ; 
      0 0 0 1];

J = Robot.ikine(T,[0 0 0],[1 1 1 0 0 0])*180/pi; % Tersini alma işemin yapıldığı yer.

handles.Aci_1.String = num2str(floor(J(1)));

handles.Aci_2.String = num2str(floor(J(2)));

handles.Aci_3.String = num2str(floor(J(3)));

Robot.plot(J*pi/180); % Ters alma işlemi yapıldıktan sonra ekranımzda robot kolunun yer değiştirdiğini görebilceğiz.


# PROJE SONU

Tüm bu işlemlerden sonra projeyi çalıştırın ve karşınıza gelen arayüzden açıları girerek "tamam" a tıklayın. Karşınıza gelen arayüzden değerleri değiştirerek robot simülasyonunu rahatça kullabilirisniz. Projenin tam halini "robotik" klasöründen bulabilirsiniz.

Abdurrahman Toruncu

SELÇUK ÜNİVERSİTESİ ELEKTRİK-ELEKTRONİK MÜHENDİSLİĞİ BÖLÜMÜ.













