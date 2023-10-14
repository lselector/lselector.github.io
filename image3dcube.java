
import java.applet.Applet;
import java.applet.AppletContext;
import java.awt.*;
import java.awt.image.MemoryImageSource;
import java.awt.image.PixelGrabber;
import java.io.PrintStream;
import java.net.MalformedURLException;
import java.net.URL;

public class image3dcube extends Applet
    implements Runnable
{

    public void init()
    {
        super.init();
        setLayout(null);
        B();
        I = size();
        D8 = I.width >= I.height ? I.height : I.width;
        D9 = D8 / 2;
        double d1 = D9;
        double ad[] = {
            -d1, -d1, -d1, d1, -d1, -d1, d1, d1, -d1, -d1, 
            d1, -d1, -d1, -d1, d1, d1, -d1, d1, d1, d1, 
            d1, -d1, d1, d1
        };
        a = ad;
        J = I.width / 2;
        K = I.height / 2;
        y = 1.0D;
        z = -1D;
        S = new int[I.height];
        T = new int[I.height];
        Q = new int[I.width * I.height];
        W = new int[I.width * I.height];
        X = new int[I.width * I.height];
        DF = new int[I.width];
        for(int i1 = 0; i1 < I.width; i1++)
            DF[i1] = 0xff000000 + D5;

        V = new int[I.height];
        for(int j1 = 0; j1 < I.height; j1++)
            V[j1] = 0;

        B = getGraphics();
        d = 512;
        e = 900;
        DD = 6;
        g = 30;
        f = a.length / 3;
        Z = new double[a.length];
        G = createImage(I.width, I.height);
        C = G.getGraphics();
        C.setColor(new Color(D3));
        C.fillRect(0, 0, I.width, I.height);
        if(E0)
        {
            F = getImage(getDocumentBase(), "on.gif");
            C(F);
            C.drawImage(F, I.width - 18, I.height - 32, this);
        }
        PixelGrabber pixelgrabber = new PixelGrabber(G, 0, 0, I.width, I.height, W, 0, I.width);
        try
        {
            pixelgrabber.grabPixels();
        }
        catch(InterruptedException _ex) { }
        if(E0)
        {
            F = getImage(getDocumentBase(), "off.gif");
            C(F);
            C.drawImage(F, I.width - 18, I.height - 32, this);
        }
        pixelgrabber = new PixelGrabber(G, 0, 0, I.width, I.height, X, 0, I.width);
        try
        {
            pixelgrabber.grabPixels();
            return;
        }
        catch(InterruptedException _ex)
        {
            return;
        }
    }

    public void run()
    {
        E = createImage(I.width, I.height);
        Graphics g1 = E.getGraphics();
        String s1 = "";
        FontMetrics fontmetrics = g1.getFontMetrics();
        DE = new int[I.width * I.height * 6];
        E5 = true;
        for(int i1 = 0; i1 < 6; i1++)
        {
            g1.setColor(new Color(D3));
            g1.fillRect(0, 0, I.width, I.height);
            g1.setColor(new Color(D4));
            String s2 = "Loading Image " + Integer.toString(i1 + 1);
            g1.drawString(s2, J - fontmetrics.stringWidth(s2) / 2, K);
            update(B);
            if(getParameter("image" + Integer.toString(i1)) != null)
            {
                // load only one image
                if (i1 == 0) {
                  F0 = getImage(getDocumentBase(), getParameter("image" + Integer.toString(i1)));
                }
                F = F0;
                C(F);
                F = I(F, D8, D8);
                System.arraycopy(U, 0, DE, i1 * D8 * D8, D8 * D8);
            }
        }

        E5 = false;
        D2 = 0.0D;
        D0 = 50D;
        D1 = 50D;
        E3 = false;
        E4 = false;
        E5 = false;
        E6 = false;
        E7 = false;
        E8 = false;
        E9 = false;
        M();
        System.arraycopy(a, 0, Z, 0, a.length);
        n = r = v = 0.0D;
        k = p = u = 1.0D;
        l = m = o = q = s = t = 0.0D;
        C4 = C5 = C6 = 0.0D;
        F();
        E7 = false;
        do
        {
            E2 = E1;
            n = r = v = 0.0D;
            if(E8)
            {
                v = 750D;
                double d1 = Math.asin(Math.sqrt(CA * CA + CB * CB));
                double d2 = Math.sqrt(CA * CA + CB * CB);
                double d3 = (int)(d1 / C2);
                for(int j1 = 0; (double)j1 < d3; j1++)
                {
                    D(-CB / d2, CA / d2, 0.0D, C2, 1.0D);
                    A();
                    E5 = true;
                    update(B);
                    E5 = false;
                }

                D(-CB / d2, CA / d2, 0.0D, d1 - d3 * C2, 1.0D);
                A();
                E5 = true;
                update(B);
                E5 = false;
                double d4 = Math.acos(CD);
                if(CE > 0.0D)
                    d4 = -d4;
                int k1 = Math.max((int)(Math.abs(d4) / C2 / 3D), 5);
                double d5 = Math.exp(Math.log(1.45D) / (double)k1);
                for(int l1 = 1; l1 <= k1; l1++)
                {
                    D(0.0D, 0.0D, -1D, -d4 / (double)k1, d5);
                    A();
                    E5 = true;
                    update(B);
                    E5 = false;
                }

                while(!E4) 
                {
                    E5 = true;
                    try
                    {
                        Thread.sleep(100L);
                    }
                    catch(InterruptedException _ex) { }
                }
                for(int i2 = 1; i2 <= k1; i2++)
                {
                    D(0.0D, 0.0D, -1D, d4 / (double)k1, 1.0D / d5);
                    A();
                    E5 = true;
                    update(B);
                    E5 = false;
                }

                v = 750D;
                d2 = Math.sqrt(CA * CA + CB * CB);
                for(int j2 = 0; (double)j2 < d3; j2++)
                {
                    D(-CB / d2, CA / d2, 0.0D, -C2, 1.0D);
                    A();
                    E5 = true;
                    update(B);
                    E5 = false;
                }

                D(-CB / d2, CA / d2, 0.0D, -d1 + d3 * C2, 1.0D);
                A();
                E5 = true;
                update(B);
                E5 = false;
                n = r = v = 0.0D;
                C4 = w;
                C5 = x;
                E8 = false;
                E3 = false;
            } else
            if(E6)
            {
                C4 = w;
                C5 = x;
            } else
            {
                if(E7)
                {
                    O = System.currentTimeMillis();
                    C4 = C5 = w = x = 0.0D;
                    E7 = false;
                }
                if(System.currentTimeMillis() - O > 5000L)
                {
                    C5 = C3;
                    C4 = (2D * C3) / 3D;
                }
            }
            E();
            G();
            C9 = 750D;
            J();
            F();
            A();
            E5 = true;
            update(B);
            E5 = false;
            try
            {
                Thread.sleep(b);
            }
            catch(InterruptedException _ex) { }
        } while(true);
    }

    public void A()
    {
        E.flush();
        E9 = false;
        if(E2)
            System.arraycopy(W, 0, Q, 0, I.width * I.height);
        else
            System.arraycopy(X, 0, Q, 0, I.width * I.height);
        int i1 = 0;
        int ai[] = new int[f];
        int ai1[] = new int[f];
        int j1 = 0;
        for(int l1 = 0; l1 < f * 3; l1 += 3)
        {
            int i2 = (int)Z[l1];
            int k2 = (int)Z[l1 + 1];
            int l2 = (int)Z[l1 + 2];
            ai[j1] = (i2 * d) / l2 + J;
            ai1[j1] = (k2 * d) / l2 + K;
            j1++;
        }

        int j2 = 0;
        Polygon polygon = new Polygon();
        int i3 = Y[0];
        for(int j3 = 0; j3 < g; j3++)
        {
            int k3 = Y[j3];
            if(k3 < 0)
            {
                polygon.addPoint(ai[i3], ai1[i3]);
                i3 = Y[j3 + 1];
                byte byte0 = 0;
                byte byte1 = 0;
                byte byte3 = 0;
                byte byte5 = 0;
                switch(i1)
                {
                case 0: // '\0'
                    byte0 = 0;
                    byte1 = 1;
                    byte3 = 3;
                    byte5 = 2;
                    break;

                case 1: // '\001'
                    byte0 = 5;
                    byte1 = 4;
                    byte3 = 6;
                    byte5 = 7;
                    break;

                case 2: // '\002'
                    byte0 = 4;
                    byte1 = 5;
                    byte3 = 0;
                    byte5 = 1;
                    break;

                case 3: // '\003'
                    byte0 = 3;
                    byte1 = 2;
                    byte3 = 7;
                    byte5 = 6;
                    break;

                case 4: // '\004'
                    byte0 = 1;
                    byte1 = 5;
                    byte3 = 2;
                    byte5 = 6;
                    break;

                case 5: // '\005'
                    byte0 = 4;
                    byte1 = 0;
                    byte3 = 7;
                    byte5 = 3;
                    break;
                }
                Polygon polygon1 = new Polygon();
                double d1 = (double)e - D2;
                double d2 = ((Z[byte1 * 3] - D0) * d1) / (Z[byte1 * 3 + 2] - D2);
                double d3 = ((Z[byte1 * 3 + 1] - D1) * d1) / (Z[byte1 * 3 + 2] - D2);
                double d5 = ((Z[byte0 * 3] - D0) * d1) / (Z[byte0 * 3 + 2] - D2);
                double d7 = ((Z[byte0 * 3 + 1] - D1) * d1) / (Z[byte0 * 3 + 2] - D2);
                double d9 = ((Z[byte3 * 3] - D0) * d1) / (Z[byte3 * 3 + 2] - D2);
                double d11 = ((Z[byte3 * 3 + 1] - D1) * d1) / (Z[byte3 * 3 + 2] - D2);
                double d13 = ((Z[byte5 * 3] - D0) * d1) / (Z[byte5 * 3 + 2] - D2);
                double d15 = ((Z[byte5 * 3 + 1] - D1) * d1) / (Z[byte5 * 3 + 2] - D2);
                polygon1.addPoint((int)((d2 * (double)d) / d1 + (double)J), (int)((d3 * (double)d) / d1 + (double)J));
                polygon1.addPoint((int)((d5 * (double)d) / d1 + (double)J), (int)((d7 * (double)d) / d1 + (double)J));
                polygon1.addPoint((int)((d9 * (double)d) / d1 + (double)J), (int)((d11 * (double)d) / d1 + (double)J));
                polygon1.addPoint((int)((d13 * (double)d) / d1 + (double)J), (int)((d15 * (double)d) / d1 + (double)J));
                int ai2[] = polygon1.ypoints;
                int ai3[] = new int[2];
                ai3 = N(polygon1.xpoints, polygon1.ypoints);
                int j5 = ai3[0];
                int k5 = ai3[1];
                for(int l5 = Math.max(ai2[k5], 0); l5 < Math.min(ai2[j5], I.height); l5++)
                {
                    int i6 = Math.min(S[l5], T[l5]);
                    int j6 = Math.max(S[l5], T[l5]);
                    System.arraycopy(DF, 0, Q, i6 + l5 * I.width, j6 - i6);
                }

                i1++;
                polygon = new Polygon();
                j2 = j3 + 1;
            } else
            {
                polygon.addPoint(ai[k3], ai1[k3]);
            }
        }

        j2 = 0;
        polygon = new Polygon();
        i3 = Y[0];
        i1 = 0;
        for(int l3 = 0; l3 < g; l3++)
        {
            int i4 = Y[l3];
            if(i4 < 0)
            {
                polygon.addPoint(ai[i3], ai1[i3]);
                i3 = Y[l3 + 1];
                byte byte2 = 0;
                byte byte4 = 0;
                byte byte6 = 0;
                boolean flag = false;
                switch(i1)
                {
                case 0: // '\0'
                    byte2 = 0;
                    byte4 = 1;
                    byte6 = 3;
                    byte byte7 = 2;
                    break;

                case 1: // '\001'
                    byte2 = 5;
                    byte4 = 4;
                    byte6 = 6;
                    byte byte8 = 7;
                    break;

                case 2: // '\002'
                    byte2 = 4;
                    byte4 = 5;
                    byte6 = 0;
                    boolean flag1 = true;
                    break;

                case 3: // '\003'
                    byte2 = 3;
                    byte4 = 2;
                    byte6 = 7;
                    byte byte9 = 6;
                    break;

                case 4: // '\004'
                    byte2 = 1;
                    byte4 = 5;
                    byte6 = 2;
                    byte byte10 = 6;
                    break;

                case 5: // '\005'
                    byte2 = 4;
                    byte4 = 0;
                    byte6 = 7;
                    byte byte11 = 3;
                    break;
                }
                int j4 = ai[byte6] - ai[byte2];
                int k4 = ai1[byte6] - ai1[byte2];
                int l4 = ai[byte4] - ai[byte2];
                int i5 = ai1[byte4] - ai1[byte2];
                if(j4 * i5 - k4 * l4 <= 0)
                {
                    double d4 = (Z[byte4 * 3] - Z[byte2 * 3]) / (double)D8;
                    double d6 = (Z[byte4 * 3 + 1] - Z[byte2 * 3 + 1]) / (double)D8;
                    double d8 = (Z[byte4 * 3 + 2] - Z[byte2 * 3 + 2]) / (double)D8;
                    double d10 = (Z[byte6 * 3] - Z[byte2 * 3]) / (double)D8;
                    double d12 = (Z[byte6 * 3 + 1] - Z[byte2 * 3 + 1]) / (double)D8;
                    double d14 = (Z[byte6 * 3 + 2] - Z[byte2 * 3 + 2]) / (double)D8;
                    double d16 = Z[byte2 * 3];
                    double d17 = Z[byte2 * 3 + 1];
                    double d18 = Z[byte2 * 3 + 2];
                    double d19 = d12 * d8 - d14 * d6;
                    double d20 = d14 * d4 - d10 * d8;
                    double d21 = d10 * d6 - d12 * d4;
                    double d22 = Math.sqrt(d19 * d19 + d20 * d20 + d21 * d21);
                    d19 /= d22;
                    d20 /= d22;
                    d21 /= d22;
                    double d23 = (double)DA - (d16 + (double)D9 * d4 + (double)D9 * d10);
                    double d24 = (double)DB - (d17 + (double)D9 * d6 + (double)D9 * d12);
                    double d25 = (double)DC - (d18 + (double)D9 * d8 + (double)D9 * d14);
                    int k1 = j2;
                    polygon = new Polygon();
                    int k6 = Y[k1];
                    do
                    {
                        polygon.addPoint(ai[k6], ai1[k6]);
                        k6 = Y[++k1];
                    } while(k6 >= 0);
                    double d26 = (d23 * d19 + d24 * d20 + d25 * d21) / Math.sqrt(d23 * d23 + d24 * d24 + d25 * d25);
                    int l6 = E2 & (!E8) ? 255 : Math.max(Math.min((int)(255D * d26 * 0.90000000000000002D + 25.5D), 255), 20);
                    int ai4[] = new int[2];
                    ai4 = N(polygon.xpoints, polygon.ypoints);
                    int i7 = Math.min(polygon.ypoints[ai4[0]], I.height);
                    int j7 = Math.max(polygon.ypoints[ai4[1]], 0);
                    double d27 = (double)d * (d4 * d18 - d8 * d16);
                    double d28 = (double)d * (d8 * d10 - d4 * d14);
                    double d29 = (double)d * (d8 * d17 - d6 * d18);
                    double d30 = (double)d * (d6 * d14 - d8 * d12);
                    double d31 = (double)(d * d) * (d6 * d16 - d4 * d17);
                    double d32 = (double)(d * d) * (d4 * d12 - d6 * d10);
                    double d33 = (double)d * (d10 * d18 - d14 * d16);
                    double d34 = (double)d * (d14 * d4 - d10 * d8);
                    double d35 = (double)d * (d14 * d17 - d12 * d18);
                    double d36 = (double)d * (d12 * d8 - d14 * d6);
                    double d37 = (double)(d * d) * (d12 * d16 - d10 * d17);
                    double d38 = (double)(d * d) * (d10 * d6 - d12 * d4);
                    int k7 = I.width;
                    int l7 = i1 * D8 * D8;
                    if(!E2 || E8)
                    {
                        for(int k9 = j7; k9 < i7; k9++)
                        {
                            double d43 = (double)(k9 - K) * d27 + d31;
                            double d45 = (double)(k9 - K) * d28 + d32;
                            double d39 = (double)(k9 - K) * d33 + d37;
                            double d41 = (double)(k9 - K) * d34 + d38;
                            int l9 = Math.min(S[k9], T[k9]);
                            int i10 = Math.max(S[k9], T[k9]);
                            double d51 = (double)(l9 - J) * d35 + d39;
                            double d55 = (double)(l9 - J) * d36 + d41;
                            double d53 = (double)(l9 - J) * d29 + d43;
                            double d57 = (double)(l9 - J) * d30 + d45;
                            int j10 = k9 * k7;
                            for(int k10 = l9; k10 <= i10; k10++)
                            {
                                if(k10 >= 0 && k10 < k7)
                                {
                                    double d49 = d51 / d55;
                                    double d47 = d53 / d57;
                                    int i8 = (int)d49;
                                    int k8 = (int)d47;
                                    i8 = i8 >= 0 ? i8 <= D8 - 1 ? i8 : D8 - 1 : 0;
                                    k8 = k8 >= 0 ? k8 <= D8 - 1 ? k8 : D8 - 1 : 0;
                                    int i9 = DE[l7 + i8 + D8 * k8];
                                    int l10 = (i9 & 0xff) * l6 & 0xff00;
                                    int i11 = ((i9 & 0xff00) >> 8) * l6 & 0xff00;
                                    int j11 = ((i9 & 0xff0000) >> 16) * l6 & 0xff00;
                                    Q[k10 + j10] = 0xff000000 + (j11 << 8) + i11 + (l10 >> 8);
                                }
                                d51 += d35;
                                d55 += d36;
                                d53 += d29;
                                d57 += d30;
                            }

                        }

                    } else
                    {
                        double d65 = Math.sqrt((0.0D - D0) * (0.0D - D0) + (0.0D - D1) * (0.0D - D1) + (750D - D2) * (750D - D2));
                        double d66 = -D0 / d65;
                        double d67 = -D1 / d65;
                        double d68 = (750D - D2) / d65;
                        for(int l12 = j7; l12 < i7; l12++)
                        {
                            int i13 = Math.min(S[l12], T[l12]);
                            int j13 = Math.max(S[l12], T[l12]);
                            double d44 = (double)(l12 - K) * d27 + d31;
                            double d46 = (double)(l12 - K) * d28 + d32;
                            double d40 = (double)(l12 - K) * d33 + d37;
                            double d42 = (double)(l12 - K) * d34 + d38;
                            double d52 = (double)(i13 - J) * d35 + d40;
                            double d56 = (double)(i13 - J) * d36 + d42;
                            double d54 = (double)(i13 - J) * d29 + d44;
                            double d58 = (double)(i13 - J) * d30 + d46;
                            int k13 = l12 * k7;
                            for(int l13 = i13; l13 <= j13; l13++)
                            {
                                if(l13 >= 0 && l13 < k7)
                                {
                                    double d50 = d52 / d56;
                                    double d48 = d54 / d58;
                                    double d59 = (d16 + d4 * d50 + d10 * d48) - D0;
                                    double d61 = (d17 + d6 * d50 + d12 * d48) - D1;
                                    double d62 = (d18 + d8 * d50 + d14 * d48) - D2;
                                    double d63 = Math.sqrt(d59 * d59 + d61 * d61 + d62 * d62);
                                    d59 /= d63;
                                    d61 /= d63;
                                    d62 /= d63;
                                    double d64 = d66 * d59 + d67 * d61 + d68 * d62;
                                    double d69 = -(d19 * d59 + d20 * d61 + d21 * d62);
                                    double d70 = Math.max(35D * (d64 - 0.95999999999999996D), 0.0D);
                                    int j12 = (int)(((double)l6 * (d69 * (d70 * d70 + 1.0D))) / 2D) - 255;
                                    int k12 = (int)(255D * (50D * Math.max(d69 - 0.95999999999999996D, 0.025000000000000001D)));
                                    int j8 = (int)d50;
                                    int l8 = (int)d48;
                                    j8 = j8 >= 0 ? j8 <= D8 - 1 ? j8 : D8 - 1 : 0;
                                    l8 = l8 >= 0 ? l8 <= D8 - 1 ? l8 : D8 - 1 : 0;
                                    int j9 = DE[l7 + j8 + D8 * l8];
                                    int i12 = j9 & 0xff;
                                    int l11 = (j9 & 0xff00) >> 8;
                                    int k11 = (j9 & 0xff0000) >> 16;
                                    i12 *= k12;
                                    l11 *= k12;
                                    k11 *= k12;
                                    i12 >>= 8;
                                    l11 >>= 8;
                                    k11 >>= 8;
                                    i12 += j12;
                                    l11 += j12;
                                    k11 += j12;
                                    i12 = i12 <= 255 ? i12 : 255;
                                    l11 = l11 <= 255 ? l11 : 255;
                                    k11 = k11 <= 255 ? k11 : 255;
                                    i12 = i12 >= 0 ? i12 : 0;
                                    l11 = l11 >= 0 ? l11 : 0;
                                    k11 = k11 >= 0 ? k11 : 0;
                                    Q[l13 + k13] = 0xff000000 + (k11 << 16) + (l11 << 8) + i12;
                                }
                                d52 += d35;
                                d56 += d36;
                                d54 += d29;
                                d58 += d30;
                            }

                        }

                    }
                    if(polygon.inside(L, M))
                    {
                        D6 = i1;
                        E9 = true;
                        if(E4 && !E8)
                        {
                            CA = d19;
                            CB = d20;
                            CC = d21;
                            double d60 = Math.sqrt(d4 * d4 + d6 * d6 + d8 * d8);
                            CD = d4 / d60;
                            CE = d6 / d60;
                            CF = d8 / d60;
                            D6 = i1;
                            E8 = true;
                            E4 = false;
                        } else
                        {
                            E4 = false;
                        }
                    }
                }
                i1++;
                polygon = new Polygon();
                j2 = l3 + 1;
            } else
            {
                polygon.addPoint(ai[i4], ai1[i4]);
            }
        }

        E = createImage(new MemoryImageSource(I.width, I.height, Q, 0, I.width));
        C(E);
        if(!E9)
            D6 = 7;
    }

    public int[] N(int ai[], int ai1[])
    {
        System.arraycopy(V, 0, S, 0, I.height);
        System.arraycopy(V, 0, T, 0, I.height);
        int i1 = 0xff000001;
        int j1 = 0xffffff;
        int k1 = 5;
        int l1 = 5;
        for(int i2 = 0; i2 < 4; i2++)
        {
            if(ai1[i2] < j1)
            {
                j1 = ai1[i2];
                l1 = i2;
            }
            if(ai1[i2] > i1)
            {
                i1 = ai1[i2];
                k1 = i2;
            }
        }

        int j2 = (l1 + 1) % 4;
        int k2 = ((4 + l1) - 1) % 4;
        byte byte0 = 5;
        if(ai[j2] < ai[k2])
        {
            K(ai[j2], ai1[j2], ai[l1], ai1[l1], true);
            K(ai[k2], ai1[k2], ai[l1], ai1[l1], false);
            if(j2 == k1)
            {
                int l2 = ((4 + l1) - 2) % 4;
                K(ai[k2], ai1[k2], ai[l2], ai1[l2], false);
                K(ai[l2], ai1[l2], ai[k1], ai1[k1], false);
            } else
            if(k2 == k1)
            {
                int i3 = (l1 + 2) % 4;
                K(ai[j2], ai1[j2], ai[i3], ai1[i3], true);
                K(ai[i3], ai1[i3], ai[k1], ai1[k1], true);
            } else
            {
                K(ai[j2], ai1[j2], ai[k1], ai1[k1], true);
                K(ai[k2], ai1[k2], ai[k1], ai1[k1], false);
            }
        } else
        {
            K(ai[j2], ai1[j2], ai[l1], ai1[l1], false);
            K(ai[k2], ai1[k2], ai[l1], ai1[l1], true);
            if(j2 == k1)
            {
                int j3 = ((4 + l1) - 2) % 4;
                K(ai[k2], ai1[k2], ai[j3], ai1[j3], true);
                K(ai[j3], ai1[j3], ai[k1], ai1[k1], true);
            } else
            if(k2 == k1)
            {
                int k3 = (l1 + 2) % 4;
                K(ai[j2], ai1[j2], ai[k3], ai1[k3], false);
                K(ai[k3], ai1[k3], ai[k1], ai1[k1], false);
            } else
            {
                K(ai[j2], ai1[j2], ai[k1], ai1[k1], false);
                K(ai[k2], ai1[k2], ai[k1], ai1[k1], true);
            }
        }
        int ai2[] = {
            k1, l1
        };
        return ai2;
    }

    public void K(int i1, int j1, int k1, int l1, boolean flag)
    {
        int i2 = k1 - i1;
        int j2 = l1 - j1;
        if(Math.abs(i2) > Math.abs(j2))
        {
            if(i2 < 0)
            {
                int k2 = i1;
                i1 = k1;
                k1 = k2;
                k2 = j1;
                j1 = l1;
                l1 = k2;
            }
            byte byte1;
            if(l1 > j1)
                byte1 = 1;
            else
                byte1 = -1;
            i2 = k1 - i1;
            j2 = Math.abs(l1 - j1);
            int l2 = i1;
            int k3 = j1;
            int i4 = -(i2 / 2);
            if(l2 >= 0 && k3 >= 0 && k3 < I.height)
                if(flag)
                    S[k3] = Math.min(l2, I.width - 1);
                else
                    T[k3] = Math.min(l2, I.width - 1);
            while(l2 < k1) 
            {
                boolean flag1 = false;
                i4 += j2;
                if(i4 >= 0)
                {
                    k3 += byte1;
                    i4 -= i2;
                    flag1 = true;
                }
                if(++l2 >= 0 && k3 >= 0 && k3 < I.height && flag1)
                    if(flag)
                        S[k3] = Math.min(l2, I.width - 1);
                    else
                        T[k3] = Math.min(l2, I.width - 1);
            }
            return;
        }
        if(j2 < 0)
        {
            int i3 = i1;
            i1 = k1;
            k1 = i3;
            i3 = j1;
            j1 = l1;
            l1 = i3;
        }
        byte byte0;
        if(k1 > i1)
            byte0 = 1;
        else
            byte0 = -1;
        i2 = Math.abs(k1 - i1);
        j2 = l1 - j1;
        int j3 = i1;
        int l3 = j1;
        int j4 = -(j2 / 2);
        if(j3 >= 0 && l3 >= 0 && l3 < I.height)
            if(flag)
                S[l3] = Math.min(j3, I.width - 1);
            else
                T[l3] = Math.min(j3, I.width - 1);
        while(l3 < l1) 
        {
            j4 += i2;
            if(j4 >= 0)
            {
                j3 += byte0;
                j4 -= j2;
            }
            l3++;
            if(j3 >= 0 && l3 >= 0 && l3 < I.height)
                if(flag)
                    S[l3] = Math.min(j3, I.width - 1);
                else
                    T[l3] = Math.min(j3, I.width - 1);
        }
    }

    public void M()
    {
        if(f > 0)
        {
            double d1 = 0.0D;
            for(int i1 = 0; i1 < f * 3; i1 += 3)
            {
                double d2 = a[i1];
                double d4 = a[i1 + 1];
                double d5 = a[i1 + 2];
                double d6 = Math.sqrt(d2 * d2 + d4 * d4 + d5 * d5) * Math.sqrt(2D);
                if(d6 > d1)
                    d1 = d6;
            }

            double d3 = (double)(I.width <= I.height ? I.width : I.height) / d1;
            for(int j1 = 0; j1 < f * 3; j1 += 3)
            {
                a[j1] *= d3;
                a[j1 + 1] *= d3;
                a[j1 + 2] *= d3;
            }

        }
    }

    public void B()
    {
        b = L("sleeptime", 10);
        D5 = L("shadowcolor", 16);
        D4 = L("textcolor", 16);
        D3 = L("background", 16);
        N = new String[6];
        for(int i1 = 0; i1 < 6; i1++)
        {
            N[i1] = getParameter("url" + Integer.toString(i1));
            if(N[i1] == null)
                N[i1] = "";
        }

        if(getParameter("showlightbutton") != null)
            E0 = getParameter("showlightbutton").substring(0, 1).equalsIgnoreCase("y");
        H = getParameter("target");
        C3 = ((double)L("anglestep", 10) * 3.1415926535897931D) / 180D;
        C1 = ((double)L("mouseresponse", 10) * 3.1415926535897931D) / 180D;
        C2 = ((double)L("zoomspeed", 10) * 3.1415926535897931D) / 180D;
        E1 = getParameter("spotlight").substring(0, 1).equalsIgnoreCase("y");
    }

    public void F()
    {
        for(int i1 = f * 3; (i1 -= 3) >= 0;)
        {
            double d1 = a[i1];
            double d2 = a[i1 + 1];
            double d3 = a[i1 + 2];
            Z[i1] = d1 * k + d2 * l + d3 * m + n;
            Z[i1 + 1] = d1 * o + d2 * p + d3 * q + r;
            Z[i1 + 2] = d1 * s + d2 * t + d3 * u + v;
        }

    }

    public void J()
    {
        n += C7;
        r += C8;
        v += C9;
    }

    public void D(double d1, double d2, double d3, double d4, double d5)
    {
        double d12 = Math.cos(d4);
        double d13 = Math.sin(d4);
        for(int i1 = f * 3; (i1 -= 3) >= 0;)
        {
            double d6 = Z[i1];
            double d8 = Z[i1 + 1];
            double d10 = Z[i1 + 2] - v;
            double d14 = d1 * d6 + d2 * d8 + d3 * d10;
            Z[i1] = d14 * d1 + d12 * (d6 - d14 * d1) + d13 * (d2 * d10 - d3 * d8);
            Z[i1 + 1] = d14 * d2 + d12 * (d8 - d14 * d2) + d13 * (d3 * d6 - d1 * d10);
            Z[i1 + 2] = d14 * d3 + d12 * (d10 - d14 * d3) + d13 * (d1 * d8 - d2 * d6);
            Z[i1] *= d5;
            Z[i1 + 1] *= d5;
            Z[i1 + 2] *= d5;
            Z[i1 + 2] += v;
        }

        double d7 = CD;
        double d9 = CE;
        double d11 = CF;
        double d15 = d1 * d7 + d2 * d9 + d3 * d11;
        CD = d15 * d1 + d12 * (d7 - d15 * d1) + d13 * (d2 * d11 - d3 * d9);
        CE = d15 * d2 + d12 * (d9 - d15 * d2) + d13 * (d3 * d7 - d1 * d11);
        CF = d15 * d3 + d12 * (d11 - d15 * d3) + d13 * (d1 * d9 - d2 * d7);
    }

    public void E()
    {
        double d1 = Math.cos(C4);
        double d2 = Math.sin(C4);
        double d3 = o * d1 + s * d2;
        double d4 = p * d1 + t * d2;
        double d5 = q * d1 + u * d2;
        double d6 = s * d1 - o * d2;
        double d7 = t * d1 - p * d2;
        double d8 = u * d1 - q * d2;
        o = d3;
        p = d4;
        q = d5;
        s = d6;
        t = d7;
        u = d8;
    }

    public void G()
    {
        double d1 = Math.cos(C5);
        double d2 = Math.sin(C5);
        double d3 = k * d1 + s * d2;
        double d4 = l * d1 + t * d2;
        double d5 = m * d1 + u * d2;
        double d6 = s * d1 - k * d2;
        double d7 = t * d1 - l * d2;
        double d8 = u * d1 - m * d2;
        k = d3;
        l = d4;
        m = d5;
        s = d6;
        t = d7;
        u = d8;
    }

    public void H()
    {
        double d1 = Math.cos(C6);
        double d2 = Math.sin(C6);
        double d3 = o * d1 + k * d2;
        double d4 = p * d1 + l * d2;
        double d5 = q * d1 + m * d2;
        double d6 = k * d1 - o * d2;
        double d7 = l * d1 - p * d2;
        double d8 = m * d1 - q * d2;
        o = d3;
        p = d4;
        q = d5;
        k = d6;
        l = d7;
        m = d8;
    }

    public Image I(Image image, int i1, int j1)
    {
        int k1 = image.getWidth(this);
        int l1 = image.getHeight(this);
        int ai[] = new int[k1 * l1];
        PixelGrabber pixelgrabber = new PixelGrabber(image, 0, 0, k1, l1, ai, 0, k1);
        try
        {
            pixelgrabber.grabPixels();
        }
        catch(InterruptedException _ex) { }
        U = new int[i1 * j1];
        int i2 = (0x10000 * l1) / j1;
        int j2 = (0x10000 * k1) / i1;
        int k2 = 0;
        int l2 = 0;
        for(int i3 = 0; i3 < i1; i3++)
        {
            for(int j3 = 0; j3 < j1; j3++)
            {
                U[i3 + j3 * i1] = ai[(k2 >> 16) + (l2 >> 16) * k1];
                l2 += i2;
            }

            k2 += j2;
            l2 = 0;
        }

        return createImage(new MemoryImageSource(i1, j1, U, 0, i1));
    }

    public boolean mouseDown(Event event, int i1, int j1)
    {
        if(E0 && I.height - j1 < 32 && I.width - i1 < 18)
            E1 = !E1;
        else
        if(D6 != 7)
            if(System.currentTimeMillis() - P < 500L)
            {
                E3 = true;
                if(N[D6] != null)
                {
                    URL url = null;
                    try
                    {
                        url = new URL(N[D6]);
                    }
                    catch(MalformedURLException _ex)
                    {
                        System.out.println("Invalid URL");
                        showStatus("Invalid URL");
                    }
                    getAppletContext().showDocument(url, H);
                }
            } else
            {
                E4 = true;
                P = System.currentTimeMillis();
            }
        return true;
    }

    public boolean mouseEnter(Event event, int i1, int j1)
    {
        E6 = true;
        return true;
    }

    public boolean mouseExit(Event event, int i1, int j1)
    {
        E7 = true;
        E6 = false;
        return true;
    }

    public boolean mouseMove(Event event, int i1, int j1)
    {
        E6 = true;
        L = i1;
        M = j1;
        if(E0)
        {
            if(I.width - i1 >= 18 || I.height - j1 >= 32)
            {
                w = (((double)(I.height / 2 - j1) * C1) / (double)I.width) * 2D;
                x = (((double)(I.width / 2 - i1) * C1) / (double)I.height) * 2D;
            }
        } else
        {
            w = (((double)(I.height / 2 - j1) * C1) / (double)I.width) * 2D;
            x = (((double)(I.width / 2 - i1) * C1) / (double)I.height) * 2D;
        }
        return true;
    }

    void C(Image image)
    {
        MediaTracker mediatracker = new MediaTracker(this);
        mediatracker.addImage(image, 0);
        try
        {
            mediatracker.waitForID(0);
            return;
        }
        catch(InterruptedException _ex)
        {
            return;
        }
    }

    public synchronized void paint(Graphics g1)
    {
        if(E != null && E5)
            g1.drawImage(E, 0, 0, this);
    }

    public synchronized void update(Graphics g1)
    {
        paint(g1);
    }

    public int L(String s1, int i1)
    {
        try
        {
            return Integer.parseInt(getParameter(s1), i1);
        }
        catch(NumberFormatException _ex)
        {
            return 0;
        }
    }

    public void start()
    {
        if(D == null)
        {
            D = new Thread(this);
            D.start();
        }
    }

    public void stop()
    {
        if(D != null && D.isAlive())
            D.stop();
        D = null;
    }

    public image3dcube()
    {
        c = 6;
        E0 = false;
        E1 = false;
        E2 = false;
        E3 = false;
        E4 = false;
        E5 = false;
        E6 = false;
        E7 = false;
        E8 = false;
        E9 = false;
    }

    private AppletContext A;
    private Graphics B;
    private Graphics C;
    private Thread D;
    private Image E;
    private Image F;
    private Image F0;
    private Image G;
    private String H;
    private Dimension I;
    private int J;
    private int K;
    private int L;
    private int M;
    private String N[];
    private long O;
    private long P;
    private int Q[];
    private int R[];
    private int S[];
    private int T[];
    private int U[];
    private int V[];
    private int W[];
    private int X[];
    private int Y[] = {
        3, 2, 1, 0, -1, 4, 5, 6, 7, -1, 
        0, 1, 5, 4, -1, 2, 3, 7, 6, -1, 
        1, 2, 6, 5, -1, 0, 4, 7, 3, -1, 
        -1
    };
    private double Z[];
    private double a[];
    private int b;
    private int c;
    private int d;
    private int e;
    private int f;
    private int g;
    private int h;
    private int i;
    private int j;
    private double k;
    private double l;
    private double m;
    private double n;
    private double o;
    private double p;
    private double q;
    private double r;
    private double s;
    private double t;
    private double u;
    private double v;
    private double w;
    private double x;
    private double y;
    private double z;
    private double C0;
    private double C1;
    private double C2;
    private double C3;
    private double C4;
    private double C5;
    private double C6;
    private double C7;
    private double C8;
    private double C9;
    private double CA;
    private double CB;
    private double CC;
    private double CD;
    private double CE;
    private double CF;
    private double D0;
    private double D1;
    private double D2;
    private int D3;
    private int D4;
    private int D5;
    private int D6;
    private int D8;
    private int D9;
    private int DA;
    private int DB;
    private int DC;
    private int DD;
    private int DE[];
    private int DF[];
    private boolean E0;
    private boolean E1;
    private boolean E2;
    private boolean E3;
    private boolean E4;
    private boolean E5;
    private boolean E6;
    private boolean E7;
    private boolean E8;
    private boolean E9;
}
