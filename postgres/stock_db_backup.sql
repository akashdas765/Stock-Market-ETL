PGDMP      9                }            stock_db    17.3    17.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    16395    stock_db    DATABASE     j   CREATE DATABASE stock_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE stock_db;
                     postgres    false            �            1259    16396 
   stock_data    TABLE     1  CREATE TABLE public.stock_data (
    "timestamp" timestamp without time zone NOT NULL,
    symbol character varying(20) NOT NULL,
    open double precision,
    high double precision,
    low double precision,
    close double precision,
    volume integer,
    moving_avg double precision,
    sma_5 double precision,
    ema_5 double precision,
    rsi double precision,
    volatility double precision,
    macd_line double precision,
    signal_line double precision,
    upper_band double precision,
    lower_band double precision,
    anomaly integer
);
    DROP TABLE public.stock_data;
       public         heap r       postgres    false                      0    16396 
   stock_data 
   TABLE DATA           �   COPY public.stock_data ("timestamp", symbol, open, high, low, close, volume, moving_avg, sma_5, ema_5, rsi, volatility, macd_line, signal_line, upper_band, lower_band, anomaly) FROM stdin;
    public               postgres    false    217   �       z           2606    16402    stock_data stock_data_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.stock_data
    ADD CONSTRAINT stock_data_pkey PRIMARY KEY ("timestamp", symbol);
 D   ALTER TABLE ONLY public.stock_data DROP CONSTRAINT stock_data_pkey;
       public                 postgres    false    217    217                  x��\۲#Gn|���? FU�P�}�ly���X)�����g&�3$�����ٌUV��n������ʿ��7�����?~�����q��t�6.~_v���(e����7����j��6����6`��>q_�n7�Q{�Eo'�zo�������ݚ��[�-	]No���V��5�c�m�K�M+�2��G�'y�{ݟ/f�޹�[-�L�me�OO��}>�r����Vu�}s��΁�u/���6�Vl�6}b�#��O���=�yP��ށ���>��I��In�^L��k�m�f}��տ�'��O���ۭ.'h]�����җ��ͶלL ^���n�D,�5�R�T��g��<a�z/�K���zl�������������^!�R 꺝����$b�~����e�/��i=�P�5k�^�����ǳ�P�J���^��������i��wm�b3��Y�4W��	z�\�@�&lo��H�Z�(t0���e�v{�
���w<�����)�}�L��E�;�ڳ�-]0��>���зY�7��v���̴�m��	�~����+>_�T�C~U���域~��ק�t���_n���"�f���Zn���~���.�؂т%��R#[��2��<����m��p`ۍrµU<^�Y2@3gh�L��2��X�V�}oZe�=��^���"��>_xXdh���s#�����(�F�k���g˻"������{�� �������6\ 3,=�e]���UB����(��݀끘�m������
�M�Jk�a�F���|�@�r� �'���b�u�������k�E쬺��kK��Ɵ^���m�����??�`h�·]��6tb��z6�Zm���]���]��ר%�$ۓ<~��?��r�ߘ��^�͡��,���@,M��;:Ѩ�~�[w�K��+��p^io�>�n<��fh7�1a
�I�M����C���\�dҎO ~ P�ʞ�U�g3v�Vh��Q%�1�zus�$�|�g�En��-歹@Ԍ�>&�]>���da�0O{,����-oO��BEA\i+P�!]��#���8)S���kD`�k��{g��3�|�:�<h)� �v������y���.��t ��O��Cs�j�繽���<���G���w�c	GݮD�O�������� x��-m���a�8u�����c�
n6@T���#������h�<L`���Mm��يc�'��q�n3���v]���.M|���g�O�}̐�iA�#�DgǑO�����HmU9�4K����:"���j'a�I��>�4f�a�}�%� _п����'FZ78���v2x!!g�J�,���h��|��1:zq[m&�+�	l&�w+eL��
Ya�@�Ӽ���j�m��U�s����u�����W�\�����<eaJg������޷L�Ճ����B�^7�ͼ�}N�؃��Wd���G r�2v�t��:���_?�&h����j﷉��h�OX�dӳT�0�	��0��k\��]�ai��6�R;�������R�v�x������
���ϕL�ߢ���~B6FdD�\s\�KQDS��6G�T��]��8tZcW�'BWn{�e�YNy��@�����0�cO�V�ɓ��՘0 v;�2÷q���IQ��ĀV�f��z�����[�z�D�xg����K�R~�v�{V������?�!m�c8-���h�d�B�p%M%�	�ЏW���$�
ȘU�!���W��_��e.��ݛ�?8�k�u%u�M|�68�4��H�z��<��L�W���1o��I�EB��^J�r`�΀�pNT�9�8�6+|טY���B1zʆ��nqx�!���N��I����P�o}`㰪�yJWʫv%�k�.��K���������!�q]�Ħ,lm`1��N'9�����y�H�}��Pv���F�y+@�f;�3�b�N2��O	�@ܿ�O�c3��Ә������%6A&���W��"���$����E@a����z�y�\��1��Ѽ�Vӕ�y��C"����q�/E����� !��ۼ��X�(Y�{>1����L>$꺲j:@Ua����'a�vӁ��c;�	��2�w�!2�W_@��6=���EEFf[@�I�\���سV
���YX8��C���x�w���r��b�?���Qx�J���8��3�!F�C����$�{5Ձܙ0�.�b��%r�2�+����_���^gLIt���;V�kk8/�JY�3B����ar�$+7�> �	��E��Ja�=;C��$Pi{\�-�&!/I���@�>��險+ܭ^E�ǚP�+:'�Bz@("}d��2��b?��	tuӅ�B����j��K��,9�&�f�L����B���i#w�eSoQB�h��QaՊ�9Nv�RW��ﴢ���ܱ��ws��N5��#��dK[d�ر0n�/�K5[׮疐G�zD��:x�}���Z�x�n�KN���D>S����B�X�{W�ռ��=: њeT��l5�-��*ʹ�`G�E��R�����6ٹ��d�$�Ծ�=�`������m�8�fNaI?] �(�iT��ɜGVg��K�TA�m�se¯�����W|� n{[�lW8^�E���+��T�/;J��0����+�ji;�=��y�Է�ѐ0�\o�HXi�c���N�5~��gt6�Ĳ�Ɍ�+s;5���o[M'�1M����${�^�¹�bP@��-_��{g�,���޳���<@k4n��Wx����5�7�`��Kp�qť���'��;^=:���#���A��Z������F�h�mSw�ga��ו��Q}v�Oh��j�������6��%��j�� �xg;ق�L�'�@��0ܪ�ԢT���b�u�#�O�hwuk�{��w�AB`��*���?�+�wݱ�����_����_�������.�0��@��RF�����u��Ƞ�"����s��������_��X&�ȕ�� o${EU�V�+"���֝��ۉy4%�x����5j]�HW��{�JFB`
;7W��ᖟ#8UGa	�X���!��E�ٖ��3���JF���W Î��a[.��aU�)X9_U��9�����箁���﷥��-ٰ�ɳJW�^��}�Ѝ$ט���T�Tl0�VK��/�d*��Hq�(��� �TYC=wO�R�wlpqm1�&Lˊjq����Ο����W&m0��]��m��J�Q�S`��`h
�U��l�94G' _H�U9&�!���s���A<JFC]A��Q0騂��3�|��T1����E��|�^�]�\y��k/�@Em��:F�b�~i.樍h���=Ud���3���?G�����<
��P�� t���e��/�Z_��j#�M��F=
&f^K2y���$�wW������QmqVҬ�*���`���!����-,�~G�ṢC�����٥>�yGx��1����"5�f*(*9pY�����zG�)����MER0�0zi����ɒ�ْi�u�݀�^�H�ٿrȡ��T�Lwl:�vi����g'������~��|�+o����%�-�ۑe�7H�f�����Q�`�"�=�8N�q���#~�T�k�Si`��5w3��WH'w^����r��wM���%��J��E�� ��7E/����6<��-��j {���O��+�����(�J��C36�:]@-���f���kEv�\���u���;��%�J;]@We��(��ؾB�L��Z�J'|��,:Eה!��D/����2[��^�aU�Ɛ������\�{�����O<9Mh�`�Ye�$��������E57���e���r;Y��r���(���4�� }x���}0�u3���.W��tyx���{́:���<�³������8�$��*��t7򽵴q�������~B�p�V���-Qπ,f�����S�<���}�L����.�PL�,���<�5�5�CP���k���,�F^����~au��2���VP��� �  �RR5��/��,�0����zԢ��|w�]��8=�\��{Vm��x����B�f�ƥ��WC��[�53x��:~#�m��+�60;�P���O����ƍ0����c5��ː�z�V=�r��#��AN()�r�b�#��"=o���G��U����J��1�w����w�.d��� �:ה��ؚu̚1�� �����������k���Vׂ5�Rn	�Ǯ��WJ#d��s���$n��;h��7S����i�r*&pʄ�o	\�8%�����7y����.2�J���	Cx���Kib�����!��%��A����rŇ3"S9Q�N8;�]M��P�9@���`��]Cet��;1�5�<�/�Mk�])��0GыqXqR������������j��=��;&\��q����wn�G�G��)Iȵ�N�?��f��fu���i��9�Lo�6�z�{�WPf��t�m��jl�w��t��=��	��b��7����'++�r�ޑ+G%'�>�?��4@���hx�O�˃�'>4@�4�B�Y�]s�[���splhRM�ؔ{���*��Ϸ��x�U�|~C�]Yi�4;�V���}�)cܕ�gڕC�L���PV�
����ta0k��^���{2F~��|լq�����VF}�%|�����S˾� �ڵǼ�T����>,�����Η�4M�،�z��[[u��N;>;����d��=�o��w�c��/���Pv-�4�>��-�|�FW�i�~F��,��,7~e�}��Zt5�̭���ӫy�m�F�H/�;�����ޜ�\s���Y ��0I�� �q-Ų8�X�v
�</����!�( L�AE�3(��G���tp�<�Ŏ-d4�R"����a}�B,����ڕ$�e_��x?v�4:C�ڣrț��l�Nn����c����)�K��{̣���G{��C�la1��j�G�a�uxc��0���Bp>X-��w�L����������]��	:B�pZ�Fu�~��JZַv�}�J�v}�-M� ��O1[�˛
�b0���7*�H�ό�?�T�=�G#8��%�=@����T/�飭�O����u �_i�~�n=���.z������?g�Q��wl��`X��D��_'3�ή�<�}�J ��G�=Eݽ��mt�������@     