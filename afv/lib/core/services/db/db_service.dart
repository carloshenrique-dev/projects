import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/models/configs/config_model.dart';
import 'package:up_afv/core/models/configs/preferences_model.dart';
import 'package:up_afv/core/models/customers/financial_positions_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_products_model.dart';
import 'package:up_afv/core/models/not_sale/not_sale_model.dart';
import 'package:up_afv/core/models/products/price_list_db_model.dart';
import 'package:up_afv/core/models/products/prod_model.dart';
import 'package:up_afv/core/models/products_order/products_order_model.dart';

class DbService {
  static const _dbName = 'up_afv.db';
  static const int _dbVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await Future.wait([
      _createTableConfig(db),
      _createTableCustomers(db),
      _createTableProd(db),
      _createTablePreferences(db),
      _createTablePricesList(db),
      _createTableCustomersAddress(db),
      _createTableFinancialPosition(db),
      _createTabelSalesCustomersProducts(db),
      _createTableSalesCustomersOrders(db),
      _createTableNotSale(db),
    ]);
  }

  Future<bool> clearTables() async {
    try {
      Database db = await database;
      var queryResult = await db
          .rawQuery("SELECT name FROM sqlite_master WHERE type = 'table'");
      for (var index in queryResult) {
        db.delete('${index['name']}');
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTableNotSale(Database db) async {
    try {
      await db.execute('''
          CREATE TABLE notsale (
            'code' INTEGER PRIMARY KEY,
            'motive' TEXT NOT NULL
          )
          ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTabelSalesCustomersProducts(Database db) async {
    try {
      await db.execute('''
          CREATE TABLE salescustomersproducts (
            'salesOrder' INTEGER NOT NULL,
            'customerCode' INTEGER NOT NULL,
            'item' INTEGER NOT NULL,
            'productCode' INTEGER NOT NULL,                      
            'productDescription' TEXT NOT NULL,
            'unit' TEXT NOT NULL,
            'invoicedQty' INTEGER NOT NULL,
            'requestQty' INTEGER NOT NULL,
            'unitAmount' NUMERIC(9,2) NOT NULL,
            'totalAmount' NUMERIC(9,2) NOT NULL,
            'status' TEXT NOT NULL,
            'cancellationReason' TEXT NOT NULL,
            'priceList' TEXT NOT NULL,
            'originalSaleValue' NUMERIC(9,2) NOT NULL,
            'typeOperation' TEXT NOT NULL,
            PRIMARY KEY(customerCode, salesOrder, productCode)
          );
          ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTableSalesCustomersOrders(Database db) async {
    try {
      await db.execute('''
          CREATE TABLE salescustomersorders (
            'customerCode' INTEGER NOT NULL,
            'subsidiaryCode' INTEGER NOT NULL,
            'salesOrder' INTEGER NOT NULL,
            'invoiceNumber' INTEGER NOT NULL,
            'saleDate' TEXT NOT NULL,
            'deliveryDate' TEXT NOT NULL,
            'note' TEXT NOT NULL,
            'paymentCondition' TEXT NOT NULL,
            'internalService' TEXT NOT NULL,
            'status' TEXT NOT NULL,
            'cancellationReason' TEXT NOT NULL,
            'unlockUser' TEXT NOT NULL,
            'ublockDate' TEXT NOT NULL,
            'unlockReason' TEXT NOT NULL,
            'grossAmount' NUMERIC(9,2) NOT NULL,
            'netValue' NUMERIC(9,2) NOT NULL,
            'commercialBudget' NUMERIC(9,2) NOT NULL,
            'registrationTime' TEXT NOT NULL,
            'syncDate' TEXT NOT NULL,
            'movementType' TEXT NOT NULL,
            'products' NULL,
            PRIMARY KEY(customerCode, salesOrder)
          );
          ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTableFinancialPosition(Database db) async {
    try {
      await db.execute('''
          CREATE TABLE financialposition (
            'customerCode' INTEGER NOT NULL,
            'subsidiaryCode' INTEGER NOT NULL,
            'titleCode' INTEGER NOT NULL,
            'installment' INTEGER NOT NULL,
            'type' TEXT NOT NULL,
            'issueDate' TEXT NOT NULL,
            'originalIssueDate' TEXT NOT NULL,
            'dueDate' TEXT NOT NULL,
            'amountInstallment' NUMERIC(9,2) NOT NULL,
            'ticketNumber' INTEGER NOT NULL,
            'paymentDate' TEXT NOT NULL,
            'amountInterest' NUMERIC(9,2) NOT NULL,
            'discount' NUMERIC(9,2) NOT NULL,
            'amountPaid' NUMERIC(9,2) NOT NULL,
            'series' TEXT NOT NULL,
            'installmentsQty' INTEGER NOT NULL,
            PRIMARY KEY(customerCode, titleCode)
          );
          ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTablePricesList(Database db) async {
    try {
      await db.execute('''
          CREATE TABLE priceslist (
            'productCode' INTEGER NOT NULL,
            'priceCode' TEXT NOT NULL,
            'unit' TEXT NOT NULL,
            'salePrice' NUMERIC(9,2) NOT NULL,
            'maxDiscount' NUMERIC(9,2) NOT NULL,
            'minPrice' NUMERIC(9,2) NOT NULL,
            'indexAdd' NUMERIC(9,2) NOT NULL,
            PRIMARY KEY(productCode, priceCode)
          );
          ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTableProd(Database db) async {
    try {
      await db.execute('''
          CREATE TABLE products (
            'codProd' INTEGER PRIMARY KEY,
            'descricao' TEXT NOT NULL,
            'unid' TEXT NOT NULL,
            'classe' INTEGER NOT NULL,
            'estoqueInicial' NUMERIC(12,3) NOT NULL,
            'vlrVenda' NUMERIC(12,3) NOT NULL,
            'perComissao' NUMERIC(12,3) NOT NULL,
            'obs' TEXT NOT NULL,
            'peUnid' TEXT NOT NULL,
            'fatorUnid' TEXT NOT NULL,
            'fator' NUMERIC(12,3) NOT NULL,
            'peQtd' NUMERIC(9,2) NOT NULL,
            'unidPdr' TEXT NOT NULL,
            'pesoLiq' NUMERIC(12,3) NOT NULL,
            'vrCompra' NUMERIC(12,3) NOT NULL,
            'fatObrgMulTundsAaux' TEXT NOT NULL,
            'nbm' TEXT NOT NULL,
            'proCodBar' TEXT NOT NULL,
            'imagem' TEXT NOT NULL
          );
          ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTableConfig(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE config (
          'codFilterProd' INTEGER,
          'codFilterCli' INTEGER
        );
        ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTablePreferences(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE preferences (
          'sellerCode' INTEGER PRIMARY KEY,
          'token' TEXT,
          'clientId' TEXT,
          'passwordClient' TEXT,
          'sellerName' TEXT,
          'user' TEXT,
          'password' TEXT
        );
        ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTableCustomersAddress(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE customersaddress (
          'customerCode' INTEGER NOT NULL,
          'addressCode' INTEGER NOT NULL,
          'address' TEXT,
          'city' TEXT,
          'complement' TEXT,
          'neighborhood' TEXT,
          'numberAddress' TEXT,
          'postalCode' TEXT,
          'state' TEXT,
          'type' TEXT,
          PRIMARY KEY(customerCode, addressCode)
        );
        ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> _createTableCustomers(Database db) async {
    try {
      await db.execute('''
          CREATE TABLE customers (
            'customerCode' INTEGER PRIMARY KEY,
            'corporateName' TEXT NOT NULL,
            'commercialName' TEXT NOT NULL,
            'cnpjCpf' TEXT NOT NULL,
            'ieRg' TEXT NOT NULL,
            'phones' TEXT NOT NULL,
            'sellerName' TEXT NOT NULL,
            'contact' TEXT NOT NULL,
            'activityArea' TEXT NOT NULL,
            'paymentCondition' TEXT NOT NULL,
            'attendance' TEXT NOT NULL,
            'sectorCode' TEXT NOT NULL,
            'sequency' INTEGER NOT NULL,
            'creditLimValue' NUMERIC(12,3) NOT NULL,
            'creditLimDate' TEXT NOT NULL,
            'qtyOpenBond' INTEGER NOT NULL,
            'maxAmountExpiredBond' INTEGER NOT NULL,
            'active' TEXT NOT NULL,
            'priceList' TEXT NOT NULL,
            'paymentConditionCode' INTEGER NOT NULL,
            'mail' TEXT NOT NULL,
            'eppMe' TEXT NOT NULL,
            'activityAreaCode' INTEGER NOT NULL,
            'itineraryCode' INTEGER NOT NULL,
            'customersAddressModel' NULL
          )
          ''');
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<int> insertData({required dynamic args, required String table}) async {
    Database db = await database;
    return await db.insert(table, args.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  delete() async {
    Database db = await database;
    db.delete('preferences');
  }

  Future<List<NotSaleModel>> queryNotSale() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notsale');
    return List.generate(maps.length, (i) {
      return NotSaleModel(
        code: maps[i]['code'],
        motive: maps[i]['motive'],
      );
    });
  }

  Future<List<ProdModel>> queryProducts() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('products', limit: 10);
    return List.generate(maps.length, (i) {
      return ProdModel(
        codProd: maps[i]['codProd'],
        descricao: maps[i]['descricao'] ?? 'S/ descricao',
        unid: maps[i]['unid'] ?? 'S/ unid',
        classe: maps[i]['classe']?.toInt() ?? 0,
        estoqueInicial: maps[i]['estoqueInicial']?.toDouble(),
        vlrVenda: maps[i]['vlrVenda']?.toDouble(),
        perComissao: maps[i]['perComissao']?.toDouble(),
        obs: maps[i]['obs'] ?? 'S/ obs',
        peUnid: maps[i]['peUnid'] ?? 'S/ p.e',
        fatorUnid: maps[i]['fatorUnid'] ?? 'S/ fator',
        fator: maps[i]['fator']?.toDouble(),
        peQtd: maps[i]['peQtd']?.toDouble(),
        unidPdr: maps[i]['unidPdr'] ?? 'S/ unid',
        pesoLiq: maps[i]['pesoLiq']?.toDouble(),
        vrCompra: maps[i]['vrCompra']?.toDouble(),
        nbm: maps[i]['nbm'] ?? 'S/ ncm',
        proCodBar: maps[i]['proCodBar'] ?? 'S/ codigo',
        fatObrgMulTundsAaux: maps[i]['fatObrgMulTundsAaux'] ?? 'S/ fator',
        imagem: maps[i]['imagem'],
      );
    });
  }

  Future<List<ProductsOrderModel>> queryProductsOrder() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return ProductsOrderModel(
        quantity: 0,
        product: ProdModel(
            codProd: maps[i]['codProd'],
            descricao: maps[i]['descricao'] ?? 'S/ descricao',
            unid: maps[i]['unid'] ?? 'S/ unid',
            classe: maps[i]['classe']?.toInt() ?? 0,
            estoqueInicial: maps[i]['estoqueInicial']?.toDouble(),
            vlrVenda: maps[i]['vlrVenda']?.toDouble(),
            perComissao: maps[i]['perComissao']?.toDouble(),
            obs: maps[i]['obs'] ?? 'S/ obs',
            peUnid: maps[i]['peUnid'] ?? 'S/ p.e',
            fatorUnid: maps[i]['fatorUnid'] ?? 'S/ fator',
            fator: maps[i]['fator']?.toDouble(),
            peQtd: maps[i]['peQtd']?.toDouble(),
            unidPdr: maps[i]['unidPdr'] ?? 'S/ unid',
            pesoLiq: maps[i]['pesoLiq']?.toDouble(),
            vrCompra: maps[i]['vrCompra']?.toDouble(),
            nbm: maps[i]['nbm'] ?? 'S/ ncm',
            proCodBar: maps[i]['proCodBar'] ?? 'S/ codigo',
            fatObrgMulTundsAaux: maps[i]['fatObrgMulTundsAaux'] ?? 'S/ fator',
            imagem: maps[i]['imagem']),
      );
    });
  }

  Future<List<PriceListDbModel>> queryPricesList(int productCode) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('priceslist',
        where: 'productCode = ?', whereArgs: [productCode]);
    return List.generate(maps.length, (i) {
      return PriceListDbModel(
        indexAdd: maps[i]['indexAdd']?.toDouble(),
        maxDiscount: maps[i]['maxDiscount']?.toDouble(),
        minPrice: maps[i]['minPrice']?.toDouble(),
        priceCode: maps[i]['priceCode'] ?? 'S/ cod. lista preco',
        productCode: maps[i]['productCode']?.toInt() ?? 0,
        salePrice: maps[i]['salePrice']?.toDouble(),
        unit: maps[i]['unit'] ?? 'S/ unidade',
      );
    });
  }

  Future<List<SalesCustomersItemsModel>> querySalesCustomersOrders(
      int customerCode) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        'salescustomersorders',
        where: 'customerCode = ?',
        whereArgs: [customerCode]);
    return List.generate(maps.length, (i) {
      return SalesCustomersItemsModel(
        subsidiaryCode: maps[i]['subsidiaryCode'],
        salesOrder: maps[i]['salesOrder'],
        invoiceNumber: maps[i]['invoiceNumber'],
        saleDate: maps[i]['saleDate'],
        deliveryDate: maps[i]['deliveryDate'],
        note: maps[i]['note'],
        paymentCondition: maps[i]['paymentCondition'],
        internalService: maps[i]['internalService'],
        status: maps[i]['status'],
        cancellationReason: maps[i]['cancellationReason'],
        unlockUser: maps[i]['unlockUser'],
        ublockDate: maps[i]['ublockDate'],
        unlockReason: maps[i]['unlockReason'],
        grossAmount: maps[i]['grossAmount']?.toDouble(),
        netValue: maps[i]['netValue']?.toDouble(),
        commercialBudget: maps[i]['commercialBudget']?.toDouble(),
        registrationTime: maps[i]['registrationTime'],
        syncDate: maps[i]['syncDate'],
        movementType: maps[i]['movementType'],
      );
    });
  }

  Future<List<SalesCustomersProductsModel>> querySalesCustomersProducts(
      int customerCode) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        'salescustomersproducts',
        where: 'customerCode = ?',
        whereArgs: [customerCode]);
    return List.generate(maps.length, (i) {
      return SalesCustomersProductsModel(
        salesOrder: maps[i]['salesOrder'],
        customerCode: maps[i]['customerCode'],
        item: maps[i]['item'],
        productCode: maps[i]['productCode'],
        productDescription: maps[i]['productDescription'],
        unit: maps[i]['unit'] ?? '',
        invoicedQty: maps[i]['invoicedQty'],
        requestQty: maps[i]['requestQty'],
        unitAmount: maps[i]['unitAmount']?.toDouble() ?? 0.0,
        totalAmount: maps[i]['totalAmount']?.toDouble() ?? 0.0,
        status: maps[i]['status'] ?? '',
        cancellationReason: maps[i]['cancellationReason'] ?? '',
        priceList: maps[i]['priceList'] ?? '',
        originalSaleValue: maps[i]['originalSaleValue']?.toDouble() ?? 0.0,
        typeOperation: maps[i]['typeOperation'] ?? '',
      );
    });
  }

  Future<List<FinancialPositionsItemsModel>> queryFinancialPosition(
      int customerCode) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('financialposition',
        where: 'customerCode = ?', whereArgs: [customerCode]);
    return List.generate(maps.length, (i) {
      return FinancialPositionsItemsModel(
        customerCode: maps[i]['customerCode']?.toInt(),
        subsidiaryCode: maps[i]['subsidiaryCode']?.toInt(),
        titleCode: maps[i]['titleCode']?.toInt(),
        installment: maps[i]['installment']?.toInt(),
        type: maps[i]['type'],
        issueDate: maps[i]['issueDate'],
        originalIssueDate: maps[i]['originalIssueDate'],
        dueDate: maps[i]['dueDate'],
        amountInstallment: maps[i]['amountInstallment']?.toDouble(),
        ticketNumber: maps[i]['ticketNumber']?.toInt(),
        paymentDate: maps[i]['paymentDate'],
        amountInterest: maps[i]['amountInterest']?.toDouble(),
        discount: maps[i]['discount']?.toDouble(),
        amountPaid: maps[i]['amountPaid']?.toDouble(),
        series: maps[i]['series'],
        installmentsQty: maps[i]['installmentsQty']?.toInt(),
      );
    });
  }

  Future<List<CustomersAddressModel>> queryCustomersAddress(
      int customerCode) async {
    try {
      Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('customersaddress',
          where: 'customerCode = ?', whereArgs: [customerCode]);
      return List.generate(
        maps.length,
        (i) => CustomersAddressModel(
          address: maps[i]['address'],
          numberAddress: maps[i]['numberAddress'],
          neighborhood: maps[i]['neighborhood'],
          city: maps[i]['city'],
          complement: maps[i]['complement'],
          postalCode: maps[i]['postalCode'],
          state: maps[i]['state'],
          type: maps[i]['type'],
          addressCode: maps[i]['addressCode']?.toInt(),
          customerCode: maps[i]['customerCode']?.toInt(),
        ),
      );
    } catch (e) {
      return [];
    }
  }

  Future<List<CustomersModel>> queryClients() async {
    try {
      Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('customers');
      return List.generate(maps.length, (i) {
        return CustomersModel(
          customerCode: maps[i]['customerCode'],
          corporateName: maps[i]['corporateName'],
          commercialName: maps[i]['commercialName'],
          cnpjCpf: maps[i]['cnpjCpf'],
          ieRg: maps[i]['ieRg'],
          phones: maps[i]['phones'],
          contact: maps[i]['contact'],
          activityArea: maps[i]['activityArea'],
          sellerName: maps[i]['sellerName'],
          paymentCondition: maps[i]['paymentCondition'],
          attendance: maps[i]['attendance'],
          sectorCode: maps[i]['sectorCode'],
          sequency: maps[i]['sequency'],
          creditLimValue: maps[i]['creditLimValue']?.toDouble(),
          creditLimDate: maps[i]['creditLimDate'],
          qtyOpenBond: maps[i]['qtyOpenBond'],
          maxAmountExpiredBond: maps[i]['maxAmountExpiredBond'],
          active: maps[i]['active'],
          priceList: maps[i]['priceList'],
          paymentConditionCode: maps[i]['paymentConditionCode'],
          mail: maps[i]['mail'],
          eppMe: maps[i]['eppMe'],
          activityAreaCode: maps[i]['activityAreaCode'],
          itineraryCode: maps[i]['itineraryCode'],
        );
      });
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<PreferencesModel>> queryPreferences() async {
    final db = await database;
    final preferences = await db.query('preferences');
    return preferences.map((data) => PreferencesModel.fromMap(data)).toList();
  }

  Future<void> updateData(
      {required dynamic arguments,
      required String value,
      required String table}) async {
    final db = await database;

    await db.rawUpdate('''
    UPDATE $table 
    SET $value = ? 
    ''', [arguments]);
  }

  Future<bool> updatePreferences(
      {required String table, required Map<String, Object?> values}) async {
    try {
      final db = await database;
      await db.update(table, values);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ConfigModel>> retrieveDataConfig() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('config');

    return List.generate(maps.length, (i) {
      return ConfigModel(
          codFilterProd: maps[0]['codFilterProd'],
          codFilterCli: maps[0]['codFilterCli']);
    });
  }

  Future<int> queryFilter({required int codFilter}) async {
    var lista = await retrieveDataConfig();
    if (codFilter == 0) {
      return lista[0].codFilterCli!;
    } else {
      return lista[0].codFilterProd!;
    }
  }
}
